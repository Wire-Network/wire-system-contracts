#include <sysio.roa.hpp>

// ACTION roa::addpolicy(const name& username, const name& contract_name, const type& cpu, const type& net, const type& ram, const type& timelock) {

// }

// ACTION roa::delpolicy(const name& username, const name& contract_name) {

// }
namespace sysio {

    void roa::activateroa() {
        require_auth(get_self());

        //Table index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto roa_singleton = roastate.get_or_default(roastate{});

        // Check if already initialized.
        check(!roa_singleton.is_active, "Contract already activated.");

        // Set default values
        roa_singleton.is_active = true;

        // Set values to table.
        roastate.set(roa_singleton, get_self());
    };

    void roa::adduser(const name& username) {
        userres_t userres(get_self(), get_self().value);

        auto user_itr = userres.find(username.value);
        check(user_itr == userres.end(), "Account already added");

        userres.emplace(get_self(), [&](userres& a) {
            a.username = username;
        });
    };

    void roa::deluser(const name& username) {
        // Instantiate the multi-index table
        userres_t userres(get_self(), get_self().value);

        // Find the user in the table
        auto user_itr = userres.find(username.value);
        check(user_itr != userres.end(), "Account not found");

        // Erase the user from the table
        userres.erase(user_itr);
    };
}