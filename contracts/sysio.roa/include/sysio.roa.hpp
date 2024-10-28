#pragma once

#include <sysio/sysio.hpp>
#include <sysio/print.hpp>
#include <sysio/singleton.hpp>

namespace sysio {
    class [[sysio::contract("sysio.roa")]] roa : public contract {
        public:
            using contract::contract;
            
            [[sysio::action]]
            void activateroa();

            /**
            * @brief Add a contract to a T1 Node Owner's whitelist.
            * 
            * @param username The T1 Node Owner's username.
            * @param contract_name The contract's username.
            * @param cpu The amount of CPU allocated to the contract from T1 Node Owner's pool.
            * @param net The amount of NET allocated to the contract from T1 Node Owner's pool.
            * @param ram The amount of RAM allocated to the contract from T1 Node Owner's pool.
            * @param timelock A timestamp for when the policy expires ( Expires == When the T1 node owner is allowed to delete the policy and free up their allocation )
            * @return ACTION 
            */
            // ACTION addpolicy(const name& username, const name& contract_name, const type& cpu, const type& net, const type& ram, const type& timelock);

            /**
            * @brief Remove a contract from a T1 Node Owner's whitelist.
            * 
            * @param username The T1 Node Owner's username.
            * @param contract_name The contract's username.
            * @return ACTION 
            */
            // ACTION delpolicy(const name& username, const name& contract_name);
            [[sysio::action]]
            void adduser(const name& username);
            
            [[sysio::action]]
            void  deluser(const name& username);
            
        private:

            struct [[sysio::table("roastate")]] roa_state {
                bool is_active = false;

                SYSLIB_SERIALIZE(roa_state, (is_active))
            };

            // Define a singleton type
            typedef sysio::singleton<"roastate"_n, roa_state> roastate_t;

            /**
            * @brief A table scoped by T1 Node Owners account name. Tracks the name of the contract and its alloted resource limits.
            */
            // TABLE policies {
            //     uint64_t policyId;          // Primary key: Unique identifier for the policy
            //     sysio::name contractName;   // Username of the contract whitelisted
            //     sysio::asset cpu;           // Allotment of CPU ( % of T1 holders resources )
            //     sysio::asset net;           // Allotment of NET ( % of T1 holders resources )
            //     uint64_t ram;               // Allotment of RAM ( % of T1 holders resources )
            //     sysio::name t1owner;        // T1 Node Owner's username
            //     uint64_t timeblock;         // Block number when the policy expires

            //     uint64_t primary_key() const { return policyId; }
            //     uint64_t by_name() const { return contractName.value; }
            // };

            // typedef multi_index<"policies"_n, policies,
            //     indexed_by<"byname"_n, const_mem_fun<policies, uint64_t, &policies::by_name>>
            // > policies_t;

            struct [[sysio::table]] userres {
                sysio::name username;         // Username of the T1 Node Owner
                // sysio::asset cpu;      // Total CPU allocated to the user
                // sysio::asset net;      // Total NET allocated to the user
                // uint64_t ram;          // Total RAM allocated to the user

                uint64_t primary_key() const { return username.value; }
            };

            typedef sysio::multi_index<"userres"_n, userres> userres_t;
    };
} /// namespace sysio