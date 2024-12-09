#include <sysio.roa.hpp>

namespace sysio {

    void roa::activateroa(const uint64_t& max_ram_bytes, const asset& ram_byte_price) {
        require_auth(get_self());

        //Table index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table, otherwise creates the row.
        auto state = roastate.get_or_default();

        // Check if already initialized.
        check(!state.is_active, "Contract already activated.");
        
        // Ensure ram_byte_price is set as SYS token.
        check(ram_byte_price.symbol == symbol("SYS", 4), "Ram price must be represented in SYS.");

        // TODO: Make this accurate with the delegatebw call to put network as "active" in bios boot sequence. Need to test if we will even need to bother with that any longer since rewards system is changing. 
        // Add sysio and sysio.roa to 'reslimit' table.
        reslimit_t reslimit(get_self(), name("sysio.roa").value);
        reslimit.emplace(get_self(), [&](auto& row) {
            row.owner = "sysio.roa"_n;
            row.net_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinte by default
            row.cpu_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinite by default
            row.ram_bytes = max_ram_bytes; // Set to max network bytes.
        });
        
        // TODO: Determine if we even need these, I don't think we do. Unless contract == payer? sysio.token setup to charge users, which should result in their policy paying for ram usage. This is ideal, sysio.token isn't a whitelisted contract users have to pay to use it? sysio.token rows under accounts table is part of account creation step. Creation of new tokens and the ram consumption for that, who do we want to pay for that? Don't whitelist sysio.token would mean users policies will be expected otherwise pass WIRE for gas. If white lsited, a policy row will be needed for sysio.token. 
        // reslimit_t reslimit2(get_self(), name("sysio").value);
        // reslimit2.emplace(get_self(), [&](auto& row) {
        //     row.owner = "sysio"_n;
        //     row.net_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinte by default
        //     row.cpu_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinite by default
        //     row.ram_bytes = max_ram_bytes; // Set to max network bytes.
        // });

        // reslimit_t reslimit3(get_self(), name("sysio.token").value);
        // reslimit3.emplace(get_self(), [&](auto& row) {
        //     row.owner = "sysio.token"_n;
        //     row.net_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinte by default
        //     row.cpu_weight = asset(0, symbol("SYS", 4)); // Set to 0 since system accounts have infinite by default
        //     row.ram_bytes = max_ram_bytes; // Set to max network bytes.
        // });

        // TODO: Might need to add a reslimit row for all system accounts? TBD
        // TODO: Check that setting weights for CPU / NET on system accounts doesn't mess up the infinte CPU / NET mechanism.

        // Set default values
        state.is_active = true;
        state.ram_byte_price = ram_byte_price;
        state.network_gen = 0;

        // Set values to table.
        roastate.set(state, get_self());
    };

    void roa::upramcost(const asset& ram_byte_price) {
        require_auth(get_self());

        //Singelton index
        roastate_t roastate(get_self(), get_self().value);

        // Gets values in the table.
        auto state = roastate.get();

        // Make sure ROA 'is_active' first.
        check(state.is_active, "ROA is not currently active");
        // Ensure they are setting the price in SYS.
        check(ram_byte_price.symbol == symbol("SYS", 4), "Ram price must be set in SYS.");
        
        state.ram_byte_price = ram_byte_price;

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
        
        // Create a personal policy for the Node Owner.
        policies_t policies(get_self(), owner.value);
        auto pol_itr = policies.find(owner.value);

        // Calculate 500 bytes for personal policy.
        uint64_t ram_bytes = 500; // Desired RAM in bytes
        uint64_t ram_weight_amount = ram_bytes * state.ram_byte_price.amount; // Total SYS in smallest units

        if (pol_itr == policies.end()) {
            // No personal policy exists yet as expected.
            policies.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = asset(5000, symbol("SYS", 4)); // 0.5000 SYS
                row.cpu_weight = asset(5000, symbol("SYS", 4)); // 0.5000 SYS
                row.ram_weight = asset(ram_weight_amount, symbol("SYS", 4));
                row.ram_byte_price = state.ram_byte_price;
                row.time_block = current_block_number(); // Set to current block, so they have freedom to do whatever they want with this policy.
            });
        }
        
        // Create or update reslimit for the owner
        reslimit_t reslimits(get_self(), owner.value);
        auto res_itr = reslimits.find(owner.value);

        if (res_itr == reslimits.end()) {
            reslimits.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = asset(5000, symbol("SYS", 4)); // Same as policy net_weight
                row.cpu_weight = asset(5000, symbol("SYS", 4)); // Same as policy cpu_weight
                row.ram_bytes = ram_bytes; // 500 bytes
            });
        } else {
            // If reslimit already exists, add to existing values
            reslimits.modify(res_itr, get_self(), [&](auto& row) {
                row.net_weight += asset(5000, symbol("SYS", 4)); // 0.5000 SYS
                row.cpu_weight += asset(5000, symbol("SYS", 4)); // 0.5000 SYS
                row.ram_bytes += ram_bytes;
            });
        }
        
        asset allocated_sys = asset(0, symbol("SYS", 4));
        allocated_sys += asset(5000, symbol("SYS", 4)); // 0.5000 SYS net_weight
        allocated_sys += asset(5000, symbol("SYS", 4)); // 0.5000 SYS cpu_weight
        allocated_sys += asset(ram_weight_amount, symbol("SYS", 4)); // ram_weight
        
        nodeowners.emplace(get_self(), [&](auto& row) {
            row.owner = owner;
            row.tier = tier;
            row.total_sys = get_allocation_for_tier(tier);
            row.allocated_sys = allocated_sys;
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
