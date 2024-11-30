#pragma once

#include <sysio/system.hpp> // For current_block_number
#include <sysio/singleton.hpp>

namespace sysio {
    class [[sysio::contract("sysio.roa")]] roa : public contract {
        public:
            using contract::contract;
            

            /**
             * @brief Initializes sysio.roa, should be called as last step in Bios Boot Sequence, activating the ROA resource management system.
             * 
             * @param max_ram_bytes The max amount of bytes the network has. Should match your 'global' table's value in sysio contract. Note: bytes are represented in Base 2.
             * @param ram_byte_price The cost in SYS for 1 byte of RAM. Value should change on network expansions.
             */
            [[sysio::action]]
            void activateroa(const uint64_t& max_ram_bytes, const asset& ram_byte_price);

            /**
             * TODO: Ideally make this on-notify or some automated system on network expansion. Will address this down the line.
             * 
             * @brief Updates the cost of 1 byte of RAM measured in SYS. Requires Node Owner multisig approval, should only be used on network expansion.
             * 
             * @param ram_byte_price The NEW cost in SYS for 1 byte of RAM.
             */
            [[sysio::action]]
            void upramcost(const asset& ram_byte_price);

            /**
             * TODO: Ultimately this will be changed. Either to an on-notify via whatever Wire contract manages Node Owner registration, or if that ends up being this contract we will adjust it accordingly.
             * 
             * @brief Registers 'owner' as a Node Owner granting total_sys allotment.
             * 
             * @param owner The account name of the Node Owner.
             * @param tier  The tier of Node they are an owner of. 1, 2, 3
             */
            [[sysio::action]]
            void regnodeowner(const name& owner, const uint8_t& tier, const asset& total_sys);

            /**
             * @brief Adds a row to the policies table scoped to 'issuer' ( Node Owner ) and either creates a row in 'reslimit' for 'owner' or increments the values if 'owner' already has a row.
             * 
             * NOTE: RAM that is consumed, cannot be reclaimed till the data filling it is freed up by 'owner', even after the policy is over.
             * 
             * @param owner The account to issue this policy for.
             * @param issuer The Node Owner issuing the policy.
             * @param net_weight The amount of SYS allocated for NET
             * @param cpu_weight The amount of SYS allocated for CPU
             * @param ram_weight The amount of SYS allocated for RAM. // TODO: This needs to be divisible by ram_byte_price right?
             * @param time_block A block number, the policy can't be reclaimed or reduced before this block.
             */
            [[sysio::action]]
            void addpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block);

            /**
             * TODO: How do we feel about time_block, adjust parameter name to be more clear about how it works in this scenario? Needs to be more intuitive. I believe we should break time_block adjusting to its own action. 
             * 
             * @brief Increase the resource limits on an existing policy. Adds new weights, to existing values. Can increase time_block if desired.
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             * @param net_weight The amount in SYS to increase NET by.
             * @param cpu_weight The amount in SYS to increase CPU by.
             * @param ram_weight The amount in SYS to increase RAM by. // TODO: This needs to be divisible by ram_byte_price right?
             */
            [[sysio::action]]
            void expandpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight);

            /**
             * @brief Decrease the resource limits on an existing policy. Subtracts new weights from existing values. Only callable after policie's time_block.
             * 
             * Note: Only unused RAM can be reclaimed.
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
            void reclaimmax(const name& owner, const name& issuer);

            /**
             * @brief Increases the policie's time_block extending the policies term.
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             * @param new_time_block The new block number this policy can't be reduced or reclaimed till.
             */
            [[sysio::action]]
            void extendpolicy(const name& owner, const name& issuer, const uint32_t& new_time_block);

        private:
            
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

            // ---- Private Functions ----
            /**
             * @brief Native function to attempt RAM reduction. Implemented in the core system code.
             * 
             * @param owner The account whose RAM allocation is to be reduced.
             * @param issuer The Node Owner issuing the reduction.
             * @param ram_bytes_to_reclaim The number of bytes to attempt to reclaim. If zero, reclaim as much as possible.
             * @param reclaimed_ram_weight The actual amount of RAM weight (in SYS) reclaimed. Non-const reference we will modify this with the resultant reclaimable weight.
             * @param ram_byte_price The price per byte of RAM at the time the policy was issued.
             * 
             * @return uint64_t The actual number of bytes reclaimed.
             */
            uint64_t revokeram(const name& owner, const name& issuer, uint64_t ram_bytes_to_reclaim, asset& reclaimed_ram_weight, const asset& ram_byte_price);

            /**
             * @brief A simple getter for totall allotted SYS based on tier number: 1, 2, 3
             * 
             * @return An asset containing the amount of SYS this tier gets
             */
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