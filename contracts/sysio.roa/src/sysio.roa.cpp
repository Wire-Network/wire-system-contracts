#include <sysio.roa/sysio.roa.hpp>

namespace sysio {

    void roa::activateroa(const uint64_t& max_ram_bytes, const asset& ram_byte_price) {
        require_auth(get_self());

        //Table index
        roastate_t state_singleton(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = state_singleton.get_or_default();

        // Check if already initialized.
        check(!state.is_active, "Contract already activated.");
        
        // TODO: Might not be needed? Would be nice to not hardcode SYS.
        // Ensure ram_byte_price is set as SYS token.
        check(ram_byte_price.symbol == symbol("SYS"), "Ram price must be represented in SYS.");

        // Add sysio and sysio.roa to 'reslimit' table.
        reslimit_t reslimit(get_self(), get_self().value);
        reslimit.emplace(get_self(), [&](struct reslimit& a) {
            a.owner = "sysio.roa"_n;
            a.net_weight = asset(0, "SYS"); // Set to 0 since system accounts have infinte by default
            a.cpu_weight = asset(0, "SYS"); // Set to 0 since system accounts have infinite by default
            a.ram_bytes = max_ram_bytes; // Set to max network bytes.
        });
        
        // TODO: Need to make sure sysio.roa pays for sysio's RAM usage. We can try to have all system account actions paid for by sysio.roa. Or we simply add each of them to reslimit and give them access to RAM.
        reslimit.emplace(get_self(), [&](struct reslimit& a) {
            a.owner = "sysio"_n;
            a.net_weight = asset(0, "SYS"); // Set to 0 since system accounts have infinte by default
            a.cpu_weight = asset(0, "SYS"); // Set to 0 since system accounts have infinite by default
            a.ram_bytes = max_ram_bytes; // Set to 0.
        });

        // TODO: Might need to add a reslimit row for all system accounts. TBD

        // Set default values
        state.is_active = true;
        state.ram_byte_price = ram_byte_price;

        // Set values to table.
        state_singleton.set(state, get_self());
    };

    // TODO: Decide if we want this to be an on-notify action or something other mechanism that ties into network expansion. Would be ideal for it to be automated.
    void roa::upramcost(const asset& ram_byte_price) {
        require_auth(get_self());

        //Singelton index
        roastate_t state_singleton(get_self(), get_self().value);

        // Gets values in the table.
        auto state = state_singleton.get_or_default();

        // Make sure ROA 'is_active' first.
        check(state.is_active, "ROA is not currently active");
        // Ensure they are setting the price in SYS.
        check(ram_byte_price.symbol == symbol("SYS", 4), "Ram price must be set in SYS.");
        
        state.ram_byte_price = ram_byte_price;

        // Set values to table.
        state_singleton.set(state, get_self());
    };
    
    // ! Do we want them to submit a block number or a timestamp and then we can determine the block number?
    void roa::addpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block) {
        // Can only issue policies for yourself.
        require_auth(issuer);
        
        //Singelton index
        roastate_t state_singleton(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = state_singleton.get_or_default();

        // Make sure ROA 'is_active' first.
        check(state.is_active, "ROA is not currently active");
        
        nodeowners_t nodeowners(get_self(), get_self().value);
        auto node_iter = nodeowners.find(issuer.value);
        // Make sure 'issuer' is actually a Node Owner.
        check(node_iter != nodeowners.end(), "Only Node Owners can issue policies.");

        // Get a total for the amount of SYS they are trying to allocate.
        asset total_new_allocation = net_weight + cpu_weight + ram_weight;
        asset free_sys = node_iter->total_sys - node_iter->allocated_sys;

        // Make sure they have enough unallocated SYS for this new policy.
        check(total_new_allocation <= free_sys, "Not enough unallocated SYS for this policy.");
        
        policies_t policies(get_self(), issuer.value);
        auto pol_iter = policies.find(owner.value);
        
        // Check if 'issuer' already has a policy for 'owner'
        check(pol_iter == policies.end(), "A policy already exists, use 'updatepolicy'.");

        reslimit_t reslimit(get_self(), get_self().value);
        auto res_itr = reslimit.find(owner.value);

        // Can't have a negative amount of bytes allocated; ram_weight must be either 0, or enough to cover ATLEAST 1 byte of RAM.
        check((ram_weight >= state.ram_byte_price || ram_weight == asset(0, "SYS")), "ram_weight must be 0 or greater than ram_byte_price");

        // Calculate allotment of ram_bytes: ram_weight / ram_byte_price.
        uint64_t ram_bytes = ram_weight / state.ram_byte_price; // TODO: Division results in int64_t ensure this value converts properly. Due to checks we shouldn't ever have negative values so it should map to a uint64 with no issue. Also make sure we have the correct "base" bytes of ram represented in base 2.

        // If they have a row already, this implies that 'owner' has a policy from someone else. Simply increment their 'reslimit' row, or give them a new row if none exists.
        if (res_itr == reslimit.end()) {
            reslimit.emplace(get_self(), [&](struct reslimit& a) {
                a.owner = owner;
                a.net_weight = net_weight;
                a.cpu_weight = cpu_weight;
                a.ram_bytes = ram_bytes;
                a.issuer = issuer;
            });
        } else {
            // 'owner' already has a 'reslimit' row. Simply increment weights.
            reslimit.modify(get_self(), [&](struct reslimit& a) {
                a.net_weight += net_weight;
                a.cpu_weight += cpu_weight;
                a.ram_bytes += ram_bytes;
            });
        }

        // TODO: Any validation or restrictions on time_block? Minimum, duration? Could add a column to our singleton? We have no way of enforcing some agreed upon duration.
        // Add a row to Node Owners list of policies.
        policies.emplace(get_self(), [&](struct policies& a) {
            a.owner = owner;
            a.net_weight = net_weight;
            a.cpu_weight = cpu_weight;
            a.ram_weight = ram_weight;
            a.ram_byte_price = state.ram_byte_price;
            a.time_block = time_block;
        });

        // Update 'issuer' total allocated SYS.
        nodeowners.modify(get_self(), [&](struct nodeowners& a) {
            a.allocated_sys += total_new_allocation;
        });
    };

    // TODO: Potentially make this into a 'native' ACTION since we need usage metrics of RAM.
    void roa::deletepolicy(const name& owner, const name& issuer) {
        require_auth(issuer);

        // Get a pointer to 'issuer's policies, scoped to 'issuer'
        policies_t policies(get_self(), issuer.value);
        auto pol_itr = policies.find(owner.value);
        
        // Make sure 'issuer' actually has a policy for 'owner'
        check(pol_itr != policies.end(), "You have no policy established for this owner.");
        
        // Check that the current block number is >= to the policie's time_block
        check(pol_iter->time_block <= current_block_number(), "Cannot delete a policy before its time_block");

        // Get a pointer to 'reslimit' table
        reslimit_t reslimit(get_self(), get_self().value);
        auto res_itr = reslimit.find(owner.value);

        // This should NEVER fail if a row was found under a nodeowner's policies.
        check(res_itr != reslimit.end(), "No 'reslimit' found for 'owner'.");

        // Determine how many bytes this policy gave for ram: ram_weight / ram_byte_price
        uint64_t allocated_bytes = pol_itr->ram_weight / pol_itr->ram_byte_price;
        asset total_allocated_sys = pol_itr->cpu_weight + pol_itr->net_weight + pol_itr->ram_weight;

        // TODO: Determine how many bytes are unused. If unused < allocated_bytes adjust how much gets reclaimed.
        uint64_t reclaim_bytes;
        asset reclaim_weight;

        // Not enough 'unused' bytes to reclaim full ram_weight.
        if(unused < allocated_bytes) {
            // Determine how much ram_weight can be reclaimed.
            reclaim_bytes = unused;
            reclaim_weight = unused * pol_itr->ram_byte_price; // TODO: Make sure this math works. uint64 * asset
        } else {
            // We have enough unused to reclaim full amount.
            reclaim_bytes = allocated_bytes;
            reclaim_weight = pol_itr->ram_weight;
        }

        asset total_reclaimed_sys = pol_itr->cpu_weight + pol_itr->net_weight + reclaim_weight;

        // Reclaim alloted resources from 'owner' delete row if all values are zero after reduction.
        if(res_itr->ram_bytes == reclaim_bytes) {
            reslimit.erase(res_itr);
        } else {
            reslimit.modify(get_self(), [&](struct reslimit& a) {
                a.net_weight -= pol_itr->net_weight;
                a.cpu_weight -= pol_itr->cpu_weight;
                a.ram_bytes  -= reclaim_bytes// Reclaim max amount of unused bytes.
            });
        }

        if(total_reclaimed_sys == total_allocated_sys) {
            // Reclaiming full policy, delete policy row.
            policies.erase(pol_itr);
        } else {
            // Reclaiming partial RAM, update policy.
            policies.modify(get_self(), [&](struct policies& a) {
                a.net_weight = asset(0, "SYS");
                a.cpu_weight = asset(0, "SYS");
                a.ram_weight = pol_itr->ram_weight - reclaimed_weight;
            });
        }

        // TODO: Update nodeowners alotment of sys.
        nodeowner.modify(get_self(), [&](struct nodeowners& a) {
            a.allocated_sys -= total_reclaimed_sys;
        });
    };

    void roa::updatepolicy(const name& owner, sysio::asset net_weight, sysio::asset cpu_weight, uint64_t ram_bytes, sysio::name issuer) {
        require_auth(issuer);

        // TODO: Add checks to ensure 'issuer' has enough unallocated SYS to facilitate this addtional policy consumption.

        userres_t userres(get_self(), get_self().value);

        auto user_itr = userres.find(owner.value);
        check(user_itr != userres.end(), "Account has no policy to update");

        // TODO: Checks need to be built that ram_bytes CAN NOT be lower than the already consumed RAM.
        
        userres.modify(user_itr,get_self(), [&](auto& a) {
            a.net_weight = net_weight;
            a.cpu_weight = cpu_weight;
            a.ram_bytes  = ram_bytes;
        });
    };

    // ---- Private helper methods ----
    bool roa::is_roa_active() {
        //Singelton index
        roastate_t state_singleton(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = state_singleton.get_or_default();

        return state.is_active;
    };
}