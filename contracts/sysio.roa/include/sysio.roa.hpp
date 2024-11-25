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
            void upramcost(const asset& ram_byte_price);

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
             * @brief Removes resources allocated to 'owner' by 'issuer's policy. Will remove all CPU / NET and UNUSED RAM. Rows will only be removed if all three resources are 0. Only callable after the policies 'time_block' has passed.
             * 
             * @param owner The account name that the policy is for.
             * @param issuer The Node Owner who issued the policy.
             */
            [[sysio::action]]
            void deletepolicy(const name& owner, const name& issuer);
            
            // TODO: Think about updating a policy once ram_byte_price has changed. Need to not overwrite this record of price, might be able to only allow "updating" while ram_byte_price in our singleton is the same as when the policy was issued. Would require us to allow multiple rows in 'policies' table with the same 'owner' value, not a huge deal realistically.
            /**
             * @brief Updates an already existing policy issued by 'issuer'. If the current block number is less than the policies exisiting 'time_block', values can only be increased. If it is passed 'time_block' values can be modified freely. 
             * 
             * Note: RAM that is consumed during the policies life span can't be reclaimed till the RAM is freed up by 'owner', so you can only lower ram_weight to the degree that the RAM isn't consumed. i.e. 10,000 byte allocated and 5,000 bytes were used you can only reclaim 5,000 bytes. 
             * 
             * @param owner The account this policy is issued to.
             * @param issuer The Node Owner who issued this policy.
             * @param net_weight The new amount of SYS allocated for NET.
             * @param cpu_weight The new amount of SYS allocated for CPU.
             * @param ram_weight The new amount of SYS allocated for RAM.
             * @param time_block The new block number after which this ploicy can be deleted / lowered.
             */
            [[sysio:action]]
            void updatepolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const uint64_t& ram_weight, const uint32_t& time_block);

            // TODO: Add an on-notify for registering ( populating ) Node Owners table.

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

            // ---- Private helper methods ----
            bool is_roa_active();
    };
} /// namespace sysio