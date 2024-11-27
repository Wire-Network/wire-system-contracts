#pragma once

#include <sysio/system.hpp> // For current_block_number
#include <sysio/singleton.hpp>

namespace sysio {
    class [[sysio::contract("sysio.roa")]] roa : public contract {
        public:
            using contract::contract;
            

            /**
             * @brief Initializes sysio.roa, should be called as last step in Bios Boot Sequence.
             * 
             * @param max_ram_bytes The max amount of bytes the network has. Should match your 'global' table's value in sysio contract. Note: bytes are represented in Base 2.
             * @param ram_byte_price The cost in SYS for 1 byte of RAM. Value should change on network expansions.
             */
            [[sysio::action]]
            void activateroa(const uint64_t& max_ram_bytes, const asset& ram_byte_price);

            /**
             * @brief Updates the cost of 1 byte of RAM measured in SYS. Requires Node Owner multisig approval, should only be used on network expansion.
             * 
             * @param ram_byte_price The NEW cost in SYS for 1 byte of RAM.
             */
            [[sysio::action]]
            void upramcost(const asset& ram_byte_price); //TODO: Ideally make this on-notify or some automated system on network expansion.

            /**
             * @brief Registers 'owner' as a Node Owner granting total_sys allotment.
             * 
             * @param owner The account name of the Node Owner.
             * @param tier  The tier of Node they are an owner of. 1, 2, 3
             */
            [[sysio::action]]
            void regnodeowner(const name& owner, const uint8_t& tier, const asset& total_sys);

            /**
             * @brief Adds a row to the policies table scoped to 'issuer' and either creates a row in 'reslimit' for 'owner' or increments the values if 'owner' already has a row.
             * 
             * @param owner The account to issue this policy for.
             * @param issuer The Node Owner issuing the policy.
             * @param net_weight The amount of SYS allocated for NET
             * @param cpu_weight The amount of SYS allocated for CPU
             * @param ram_weight The amount of SYS allocated for RAM
             * @param time_block A block number, the policy can't be deleted or have its values lowered before this block.
             */
            [[sysio::action]]
            void addpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block);

            /**
             * @brief Increase the resource limits on an existing policy. Adds new weights, to existing values. Can increase time_block if desired.
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             * @param net_weight The amount in SYS to increase NET by.
             * @param cpu_weight The amount in SYS to increase CPU by.
             * @param ram_weight The amount in SYS to increase RAM by.
             * @param time_block New time_block, if 0 leaves existing value, otherwise overwrites. MUST be greater than current block number, if setting a new value.
             */
            [[sysio::action]]
            void expandpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block);

            /**
             * @brief Decrease the resource limits on an existing policy. Subtracts new weights from existing values. Only callable after policie's time_block.
             * 
             * Note: RAM can't be reduced beyond what is unused.
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             * @param net_weight The amount in SYS to decrease NET by.
             * @param cpu_weight The amount in SYS to decrease CPU by.
             * @param ram_weight The amount in SYS to decrease RAM by. CANNOT REDUCE ALREADY CONSUMED RAM.
             */
            [[sysio::action]]
            void reducepolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight);

            /**
             * @brief Reclaims maximum amount of allocated resources. Zeros out CPU / NET, and reclaims all unused RAM.
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             */
            [[sysio::action]]
            void reclaimres(const name& owner, const name& issuer);


        private:
            
            // TODO: Determine the parameters we want. Should this be private? Called internally by reduce and reclaim. Make this a native action.
            [[sysio::action]]
            void reclaimram(const name& owner, const name& issuer, );

            /**
             * Config variables for ROA.
             */
            struct [[sysio::table("roastate")]] roa_state {
                bool is_active = false;
                asset ram_byte_price = asset(1, SYS); // TODO: Determine starting value.

                SYSLIB_SERIALIZE(roa_state, (is_active)(ram_byte_price))
            };

            typedef sysio::singleton<"roastate"_n, roa_state> roastate_t;

            /**
             * Basic table tracking who T1-3 Node Owners are and their availble vs allocated SYS.
             */
            struct [[sysio::table]] nodeowners {
                name owner;          // Node Owners account name.
                uint8_t tier;        // Represents what tier they hold: 1, 2, or 3
                asset total_sys;     // Total SYS alloted based on tier.
                asset allocated_sys; // Total SYS allocated via policies they issued.

                uint64_t primary_key() const { return owner.value; }
                uint8_t by_tier() const { return tier; }
            };

            typedef multi_index<"nodeowners"_n, nodeowners, 
                indexed_by<"bytier"_n, const_mem_fun<nodeowners, uint8_t, &nodeowners::by_tier>>
            > nodeowners_t;

            /**
             * This table is scoped to Node Owner's account names and is used to track all policies issued by Node Owners.
             */
            struct [[sysio::table]] policies {
                name owner;             // Account name this policy applies to.
                asset net_weight;       // The amount of SYS allocated for NET.
                asset cpu_weight;       // The amount of SYS allocated for CPU.
                asset ram_weight;       // The amount of SYS allocated for RAM.
                asset ram_byte_price;   // The price, in SYS, for 1 byte of RAM when the policy was created.
                uint32_t time_block;    // Block number, this policy can't be deleted or have its values lowered before the networks current block num >= time_block.

                uint64_t primary_key() const { return owner.value; }
            };

            typedef multi_index<"policies"_n, policies> policies_t;

            /**
             * Holds upper limits of resources an account has access to. This table is used by the Node Operators to maintain usage metrics, replaces 'userres' on sysio.
             */
            struct [[sysio::table]] reslimit {
                name owner;            // Account name this policy applies to
                asset net_weight;      // Total NET allocated
                asset cpu_weight;      // Total CPU allocated
                uint64_t ram_bytes;    // Total RAM allocated

                uint64_t primary_key() const { return owner.value; }
            };

            typedef sysio::multi_index<"reslimit"_n, reslimit> reslimit_t;

            // ---- Private Helper Functions ----
            asset get_allocation_for_tier(uint8_t tier) {
                switch (tier) {
                    case 1:
                        return asset(400000000, symbol("SYS", 4));
                    case 2:
                        return asset(17857142.8571, symbol("SYS", 4)); // Adjust value as needed
                    case 3:
                        return asset(4500, symbol("SYS", 4)); // Adjust value as needed
                    default:
                        sysio::check(false, "Invalid tier"); // Fail if tier is invalid
                        return asset(0, symbol("SYS", 4));  // Unreachable but needed for compilation
                }
            };
    };
} /// namespace sysio