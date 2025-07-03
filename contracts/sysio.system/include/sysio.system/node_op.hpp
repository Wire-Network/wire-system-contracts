#pragma once

#include <sysio/sysio.hpp>
#include <sysio/name.hpp>

/**
 * 
 */
class [[sysio::contract("sysio.system")]] node_operator : sysio::contract {
    public:
        using sysio::contract::contract;

        struct [[sysio::table, sysio::contract("sysio.system")]] oproot {
            checksum256_t     op_root;          // Current root for node operator registration
            uint64_t          order;            // Most recent order number for node operator registration
            
        };

        struct [[sysio::table("opreg"), sysio::contract("sysio.system")]] node_op_reg {
            uint64_t          order;                // Unique identifier for the node operator
            name              username;         // The name of the node operator
            sysio::public_key signing_key;      // The public signing key of the node operator
            checksum256_t     op_root;          // Checksum for the node operator registration
            uint64_t          reg_status;
        };
};