#pragma once

#include <sysio/sysio.hpp>
#include <sysio/name.hpp>

/**
 * 
 */
class [[sysio::contract("sysio.system")]] node_operator : sysio::contract {
    public:
        using sysio::contract::contract;

        // ----- Node Operator Registration Actions -----
        /**
         * @brief Action to register a node operator. This action is used to initiate the registration process for a node operator.
         * 
         * @param username The account name of the node operator.
         * @param signing_key The public Signing Key of the node operator.
         */
        [[sysio::action("regnodeop")]]
        void regnodeop(const sysio::name& username, const sysio::public_key& signing_key);

        // ----- Node Operator Registration Tables  -----

        /**
         * @brief Tracks the current root for node operator registration, the most recent order number, the block number when the root was last updated, and the account name of the last registered node operator.
         * 
         * TODO: Should block_num be uint128_t? Or should we use block_timestamp?
         */
        struct [[sysio::table, sysio::contract("sysio.system")]] oproothead {
            oproothead(){} // TODO: Do we need this? What values should we initialize to?

            bytes             op_root = {};             // Current root for node operator registration
            uint64_t          order = 0;                // Most recent order number for node operator registration
            uint128_t         block_num = 0;            // Block number when the root was last updated
            sysio::name       last_registered = {};     // The account name of the node operator last registered

            SYSIO_SERIALIZE(oproothead, (op_root)(order)(block_num)(last_registered))
        };

        /**
         * @brief A complete registration record for node operators. Includes all necessary information to replay oproots.
         * 
         * Reg Status values: 0 = initialized, 1 = propagated, 2 = finalized, 3 = unregistered
         * 
         * TODO: Determine type for reg_status. Probably smallest available integer type?
         */
        struct [[sysio::table, sysio::contract("sysio.system")]] opreg {
            uint64_t          order;            // Order number for the node operator registration
            sysio::name       username;         // The account name of the node operator
            sysio::public_key signing_key;      // The public Signing Key of the node operator
            bytes             op_root;          // Checksum for the node operator registration
            uint64_t          reg_status;       // Registration status of the node operator

            uint64_t primary_key() const { return order; }
            uint64_t by_username() const { return username.value; }
            checksum256 by_signing_key() const { return sysio::sha256(reinterpret_cast<const char*>(&signing_key), sizeof(signing_key)); }
            checksum256 by_op_root() const { return sysio::sha256(op_root.data(), op_root.size()); }
            uint64_t by_status() const { return reg_status; }
        };
        typedef sysio::multi_index<"opreg"_n, opreg,
            sysio::indexed_by<"byusername"_n, sysio::const_mem_fun<opreg, uint64_t, &opreg::by_username>>,
            sysio::indexed_by<"bysigningkey"_n, sysio::const_mem_fun<opreg, checksum256, &opreg::by_signing_key>>,
            sysio::indexed_by<"byoproot"_n, sysio::const_mem_fun<opreg, checksum256, &opreg::by_op_root>>,
            sysio::indexed_by<"bystatus"_n, sysio::const_mem_fun<opreg, uint64_t, &opreg::by_status>>
        > opreg_table;

        /**
         * @brief Scoped by operator's account name, this table is used to track the registration of node operators on external chains. Upon full registration to all chains, the node operator will be added to the `operators` table and the `opregext` table will be cleared.
         * 
         * TODO: Ideal type for block_num? This represents external chain block number.
         */
        struct [[sysio::table, sysio::contract("sysio.system")]] opregext {
            sysio::name     external_chain;     // The external chain where operator registration needs to be propagated
            sysio::name     facilitator;        // The facilitator account that will handle the propagation on the external chain
            uint128_t       block_num;          // The block number of the external chain when the registration was made
            bytes           trx_id;             // The transaction ID of the registration on the external chain
            bytes           trx_signature;      // The transaction signature of the registration on the external chain
            bytes           signed_trx;         // The signed transaction of the registration on the external chain, to be broadcasted on their behalf if needed

            uint64_t primary_key() const { return external_chain.value; }
        };

        typedef sysio::multi_index<"opregext"_n, opregext> opregext_table;

        /**
         * @brief The final node operator roster, tracking all node operators that have been registered, their scores, and their active status. 
         * 
         * TODO: Determine score's type.
         */
        struct [[sysio::table, sysio::contract("sysio.system")]] operators {
            sysio::name username;               // The account name of the node operator
            sysio::public_key signing_key;      // The public Signing Key of the node operator
            sysio::name producing_as;           // The static producer account name the node operator is producing as (alpha - uniform)
            uint128_t score;                    // The score of the node operator, used for ranking
            bool is_active;                     // Whether the node operator is currently active or not

            uint64_t primary_key() const { return username.value; }
            checksum256 by_signing_key() const { return sysio::sha256(reinterpret_cast<const char*>(&signing_key), sizeof(signing_key)); }
            checksum256 by_producing_as() const { return sysio::sha256(producing_as.to_string().c_str(), producing_as.to_string().size()); }
            uint128_t by_score() const { return score; }
            bool by_is_active() const { return is_active; }
        }; 

        typedef sysio::multi_index<"operators"_n, operators,
            sysio::indexed_by<"bysigningkey"_n, sysio::const_mem_fun<operators, checksum256, &operators::by_signing_key>>,
            sysio::indexed_by<"byproducingas"_n, sysio::const_mem_fun<operators, checksum256, &operators::by_producing_as>>,
            sysio::indexed_by<"byscore"_n, sysio::const_mem_fun<operators, uint128_t, &operators::by_score>>,
            sysio::indexed_by<"byisactive"_n, sysio::const_mem_fun<operators, bool, &operators::by_is_active>>
        > operators_table;
};