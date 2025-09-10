#include <sysio.system/node_op.hpp>

//TODO: Determine how registration fee will be handled. Some sort of check must be done.
void node_operator::regnodeop(const sysio::name& username, const sysio::public_key& signing_key) {
    // Ensure user is registering themselves.
    require_auth(username);
    
    // Ensure the signing key is a valid K1 public key.
    sysio::check(signing_key.which() == sysio::key_type::k1, "Signing key must be a K1 public key");

    // TODO: Make sure username is not already registered as an 'active' node operator. Should only allow re-registration if the node operator is 'inactive' in operators table (active == false ) and is trying to subtitute their signing key. Otherwise they should simply toggle back to active status.

    // TODO: Create opreg row.

    // TODO: Create opregext row for each external chain. Based on 'wnsmanager' table where chain == active.
    
    // TODO: Update oproothead row update the order and block_num.
}