#include <sysio.roa.hpp>

namespace sysio {

    void roa::activateroa(const uint64_t& bytes_per_unit) {
        require_auth(get_self());

        //Table index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = roastate.get_or_default();

        // Check if already initialized.
        check(!state.is_active, "Contract already activated.");

        // Set default values
        state.is_active = true;
        state.bytes_per_unit = bytes_per_unit;
        state.network_gen = 0;

        // Set values to table.
        roastate.set(state, get_self());
    };

    void roa::setbyteprice(const uint64_t& bytes_per_unit) {
        require_auth(get_self());

        //Singelton index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table.
        auto state = roastate.get();

        // Make sure ROA 'is_active' first.
        check(state.is_active, "ROA is not currently active");
        
        state.bytes_per_unit = bytes_per_unit;

        // Set values to table.
        roastate.set(state, get_self());
    };
    
    void roa::regnodeowner(const name& owner, const uint8_t& tier) {
        require_auth(get_self());

        // Make sure ROA is active and access to ram byte price.
        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not active yet");

        nodeowners_t nodeowners(get_self(), state.network_gen);
        auto node_itr = nodeowners.find(owner.value);
        
        check(node_itr == nodeowners.end(), "This account is already registered.");
        
        asset total_sys_allocation = get_allocation_for_tier(tier);

        // Sum total allocated SYS between personal policy and sysio policy.
        asset allocated_sys = asset(0, symbol("SYS", 4));
        asset personal_ram_weight = asset(80, symbol("SYS", 4)); // .0080 which is allocated to personal ram usage.
        uint64_t personal_ram_bytes = personal_ram_weight.amount() * state.bytes_per_unit;
        allocated_sys += personal_ram_weight;

        // 10% of total SYS goes to sysio to facilitate account creations and system actions.
        asset sysio_allocation = asset(total_sys_allocation.amount / 10, total_sys_allocation.symbol); 
        allocated_sys += sysio_allocation;

        // Minimal default starting weights for personal policy.
        asset net_cpu_weight = asset(500, symbol("SYS", 4));
        allocated_sys += (net_cpu_weight + net_cpu_weight);
        
        // Create a personal policy for the Node Owner.
        policies_t policies(get_self(), owner.value);
        auto pol_itr = policies.find(owner.value);

        name sysio_account = name("sysio");
        asset zero_asset = asset(0, SYMBOL("SYS", 4));

        // Get total 
        if (pol_itr == policies.end()) {
            // No policies exists yet as expected.

            // Create a minimal default policy for self.
            policies.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.issuer = owner;
                row.net_weight = net_cpu_weight; // 0.0500 SYS
                row.cpu_weight = net_cpu_weight; // 0.0500 SYS
                row.ram_weight = personal_ram_weight;  // 0.0080 SYS
                row.bytes_per_unit = state.bytes_per_unit;
                row.time_block = 1; // Set to current block, so they have freedom to do whatever they want with this policy.
            });

            // Create a sysio policy, for system functions and newaccount facilitation.
            policies.emplace(get_self(), [&](auto& row) {
                row.owner = sysio_account;
                row.issuer = owner;
                row.net_weight = zero_asset;
                row.cpu_weight = zero_asset;
                row.ram_weight = sysio_allocation; // 10% of total allocation
                row.bytes_per_unit = state.bytes_per_unit;
                row.time_block = 1; // Need to lock this up, should not be allowed to remove this policy.
            });
        }
        
        // Create or update reslimit for the owner and then set_resource_limit
        reslimit_t reslimits(get_self(), owner.value);
        auto res_itr = reslimits.find(owner.value);
        

        // TODO: Remove this check if account creation does NOT create a reslimit row. TBD after newaccount rework.
        if (res_itr == reslimits.end()) {
            reslimits.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = net_cpu_weight // Same as policy net_weight
                row.cpu_weight = net_cpu_weight // Same as policy cpu_weight
                row.ram_bytes = personal_ram_bytes;
            });

            set_resource_limit(owner, personal_ram_bytes, net_cpu_weight.amount, net_cpu_weight.amount);
        } else {
            // If reslimit already exists, add to existing values
            reslimits.modify(res_itr, get_self(), [&](auto& row) {
                row.net_weight += net_cpu_weight;
                row.cpu_weight += net_cpu_weight;
                row.ram_bytes += personal_ram_bytes;
            });

            set_resource_limit(owner, res_itr->ram_bytes, res_itr->net_weight.amount, res_itr->cpu_weight.amount); // Set resource limits with new totals.
        }

        // Create or update reslimit for sysio and then set_resource_limit
        reslimit_t sysreslimit(get_self(), sysio_account.value);
        auto sys_res_itr = reslimits2.find(sysio_account);
        // Calculate in bytes how much sysio gets.
        uint64_t sysio_bytes = sysio_allocation * state.bytes_per_unit;

        // TODO: Remove this check if account creation does NOT create a reslimit row. TBD after newaccount rework.
        if (sys_res_itr == reslimits.end()) {
            sysreslimit.emplace(get_self(), [&](auto& row) {
                row.owner = sysio_account;
                row.net_weight = net_cpu_weight // Same as policy net_weight
                row.cpu_weight = net_cpu_weight // Same as policy cpu_weight
                row.ram_bytes = sysio_bytes; // 500 bytes
            });

            set_resource_limit(sysio_account, sysio_bytes, net_cpu_weight.amount, net_cpu_weight.amount);
        } else {
            // If reslimit already exists, add to existing values
            sysreslimit.modify(sys_res_itr, get_self(), [&](auto& row) {
                row.ram_bytes += sysio_bytes;
            });

            set_resource_limit(sysio_account, sys_res_itr->ram_bytes, sys_res_itr->net_weight.amount, sys_res_itr->cpu_weight.amount); // Set resource limits with new totals.
        }
        
        nodeowners.emplace(get_self(), [&](auto& row) {
            row.owner = owner;
            row.tier = tier;
            row.total_sys = total_sys_allocation;
            row.allocated_sys = allocated_sys;
            row.network_gen = state.network_gen;
        });

        // TODO: Notify Council contract
    };

    void roa::addpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block, const uint8_t& network_gen) {
        // Can only issue policies for yourself.
        require_auth(issuer);
        
        //Singelton index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = roastate.get();

        // Make sure ROA 'is_active' first.
        check(state.is_active, "ROA is not currently active");
        
        nodeowners_t nodeowners(get_self(), network_gen);
        auto node_itr = nodeowners.find(issuer.value);
        // Make sure 'issuer' is actually a Node Owner.
        check(node_itr != nodeowners.end(), "Only Node Owners can issue policies.");

        // Validate weights (allow zero values)
        check(net_weight.amount >= 0, "NET weight cannot be negative");
        check(cpu_weight.amount >= 0, "CPU weight cannot be negative");
        check(ram_weight.amount >= 0, "RAM weight cannot be negative");

        asset ram_byte_price = state.ram_byte_price;
        // Calculate the number of bytes represented by ram_weight
        int64_t ram_bytes_to_allocate = ram_weight.amount / ram_byte_price.amount;

        // Get a total for the amount of SYS they are trying to allocate.
        asset total_new_allocation = net_weight + cpu_weight + ram_weight;
        asset free_sys = node_itr->total_sys - node_itr->allocated_sys;

        // Make sure they have enough unallocated SYS for this new policy.
        check(total_new_allocation.amount <= free_sys.amount, "Not enough unallocated SYS for this policy.");
        
        policies_t policies(get_self(), issuer.value);
        auto pol_iter = policies.find(owner.value);
        
        // Check if 'issuer' already has a policy for 'owner'
        check(pol_iter == policies.end(), "A policy already exists, use 'expandpolicy'.");

        reslimit_t reslimit(get_self(), owner.value);
        auto res_itr = reslimit.find(owner.value);

        // If they have a row already, this implies that 'owner' has a policy from someone else. Simply increment their 'reslimit' row, or give them a new row if none exists.
        if (res_itr == reslimit.end()) {
            reslimit.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = net_weight;
                row.cpu_weight = cpu_weight;
                row.ram_bytes = ram_bytes_to_allocate;
            });
        } else {
            // 'owner' already has a 'reslimit' row. Simply increment weights.
            reslimit.modify(res_itr, get_self(), [&](auto& row) {
                row.net_weight.amount += net_weight.amount;
                row.cpu_weight.amount += cpu_weight.amount;
                row.ram_bytes += ram_bytes_to_allocate;
            });
        }

        // TODO: Any validation or restrictions on time_block? Minimum, duration? Could add a column to our singleton? We have no way of enforcing some agreed upon duration.
        // Add a row to Node Owners list of policies.
        policies.emplace(get_self(), [&](auto& row) {
            row.owner = owner;
            row.issuer = issuer;
            row.net_weight = net_weight;
            row.cpu_weight = cpu_weight;
            row.ram_weight = ram_weight;
            row.ram_byte_price = ram_byte_price;
            row.time_block = time_block;
        });

        // Update 'issuer' total allocated SYS.
        nodeowners.modify(node_itr, get_self(), [&](auto& row) {
            row.allocated_sys.amount += total_new_allocation.amount;
        });
    };

    void roa::expandpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint8_t& network_gen) {
        require_auth(issuer);

        nodeowners_t nodeowners(get_self(), network_gen);
        auto node_itr = nodeowners.find(issuer.value);

        // Make sure 'issuer' is a Node Owner.
        check(node_itr != nodeowners.end(), "Only Node Owners can manage policies.");

        // Get a pointer to 'issuer's policies, scoped to 'issuer'
        policies_t policies(get_self(), issuer.value);
        auto pol_itr = policies.find(owner.value);
        
        // Make sure 'issuer' actually has a policy for 'owner'
        check(pol_itr != policies.end(), "You have no policy for this owner.");

        // Validate weights (allow zero values)
        check(net_weight.amount >= 0, "NET weight cannot be negative");
        check(cpu_weight.amount >= 0, "CPU weight cannot be negative");
        check(ram_weight.amount >= 0, "RAM weight cannot be negative");

        // Calculate the number of bytes represented by ram_weight
        int64_t ram_bytes_to_allocate = ram_weight.amount / pol_itr->ram_byte_price.amount;

        asset total_new_allocation = net_weight + cpu_weight + ram_weight;
        // Make sure 'issuer' has enough unallocated SYS to supply the policy with.
        check(total_new_allocation.amount <= (node_itr->total_sys.amount - node_itr->allocated_sys.amount), "Issuer does not have enough unallocated SYS.");

        reslimit_t reslimit(get_self(), owner.value);
        auto res_itr = reslimit.find(owner.value);

        // This should NEVER get hit, if it does BIG issues.
        check(res_itr != reslimit.end(), "No reslimit found for user.");
        
        // TODO: Consider the situation where a policy is being increased, but the 'ram_byte_price' has changed since the policy was initially established. SYS calculations need to be adjusted. This would occur if a policy is being expanded after a network expansion.
        // Increase policy allotment
        policies.modify(pol_itr, get_self(), [&](auto& row) {
            row.net_weight.amount += net_weight.amount;
            row.cpu_weight.amount += cpu_weight.amount;
            row.ram_weight.amount += ram_weight.amount;
        });

        // Increase 'issuer's allocated_sys
        nodeowners.modify(node_itr, get_self(), [&](auto& row) {
            row.allocated_sys.amount += total_new_allocation.amount;
        });

        // Increase 'owners' resource limits
        reslimit.modify(res_itr, get_self(), [&](auto& row) {
            row.net_weight.amount += net_weight.amount;
            row.cpu_weight.amount += cpu_weight.amount;
            row.ram_bytes += ram_bytes_to_allocate;
        });
    };

    void roa::extendpolicy(const name& owner, const name& issuer, const uint32_t& new_time_block) {
        require_auth(issuer);

        // Pointer to Policies table
        policies_t policies(get_self(), issuer.value);
        auto pol_itr = policies.find(owner.value);

        check(pol_itr != policies.end(), "Policy does not exist under this issuer for this owner");
        check(new_time_block > pol_itr->time_block, "Cannot reduce a policies existing time_block");
        check(new_time_block > current_block_number(), "You cannot set a time_block lower than the current block");

        policies.modify(pol_itr, get_self(), [&](auto& row) {
            row.time_block = new_time_block;
        });
    };
    
    void roa::reducepolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint8_t& network_gen) {
       
    };
} // namespace roa

SYSIO_DISPATCH(sysio::roa, (reducepolicy));
