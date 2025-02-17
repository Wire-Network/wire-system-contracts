#include <sysio.roa.hpp>

namespace sysio {

    void roa::activateroa(const asset& total_sys, const uint64_t& bytes_per_unit) {
        require_auth(get_self());

        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get_or_default();

        check(!state.is_active, "Contract already activated.");

        state.is_active = true;
        state.total_sys = total_sys;
        state.bytes_per_unit = bytes_per_unit;
        state.network_gen = 0;
        roastate.set(state, get_self());

        const int64_t total_amount = total_sys.amount; // smallest units

        // Fractions per node (rational approach):
        // T1: 4% = 4/100 (add 50 for rounding)
        int64_t t1_per_node = (total_amount * 4 + 50) / 100;
        int64_t t1_total = t1_per_node * 21;

        // T2: 0.0015 = 15/10,000 (add 5,000 for rounding)
        int64_t t2_per_node = (total_amount * 15 + 5000) / 10000;
        int64_t t2_total = t2_per_node * 84;

        // T3: 0.00003 = 3/100,000 (add 50,000 for rounding)
        int64_t t3_per_node = (total_amount * 3 + 50000) / 100000;
        int64_t t3_total = t3_per_node * 1000;

        // Allocated sum
        int64_t allocated = t1_total + t2_total + t3_total;

        // Leftover
        int64_t leftover = total_amount - allocated;

        // Split leftover in half
        int64_t half_leftover = leftover / 2;
        int64_t other_half = leftover - half_leftover; // ensures exact sum

        // Convert to bytes using bytes_per_unit = bytes per smallest unit
        uint64_t roa_ram_bytes = (uint64_t)(half_leftover * bytes_per_unit);
        uint64_t sysio_ram_bytes = (uint64_t)(other_half * bytes_per_unit);

        // Create/Update reslimit for sysio.roa (self)
        reslimit_t roareslimit(get_self(), get_self().value);
        check(roareslimit.find(get_self().value) == roareslimit.end(), "roa reslimit already exists.");
        roareslimit.emplace(get_self(), [&](auto& row) {
            row.owner = get_self();
            row.net_weight = asset(0, total_sys.symbol);
            row.cpu_weight = asset(0, total_sys.symbol);
            row.ram_bytes = roa_ram_bytes;
        });

        // Set sysio.roas new account limits.
        set_resource_limits(get_self(), roa_ram_bytes, -1, -1);

        // Create/Update reslimit for sysio
        name sys_account = "sysio"_n;
        reslimit_t sysioreslimit(get_self(), sys_account.value);
        check(sysioreslimit.find(sys_account.value) == sysioreslimit.end(), "sysio reslimit already exists.");
        sysioreslimit.emplace(get_self(), [&](auto& row) {
            row.owner = sys_account;
            row.net_weight = asset(56671995, total_sys.symbol);
            row.cpu_weight = asset(56671995, total_sys.symbol);
            row.ram_bytes = sysio_ram_bytes;
        });

        // Set sysio.roas new account limits.
        set_resource_limits(sys_account, sysio_ram_bytes, -1, -1);
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

        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not active yet");

        nodeowners_t nodeowners(get_self(), state.network_gen);
        auto node_itr = nodeowners.find(owner.value);
        check(node_itr == nodeowners.end(), "This account is already registered.");

        // Get the total SYS allocation for this tier
        asset total_sys_allocation = get_allocation_for_tier(tier);
        
        // We will track how much is allocated to bandwidth (CPU/NET) and RAM separately
        asset allocated_sys(0, state.total_sys.symbol);
        asset allocated_bw(0, state.total_sys.symbol);
        asset allocated_ram(0, state.total_sys.symbol);

        // Personal RAM allocation: For example 0.0080 SYS
        asset personal_ram_weight(80, state.total_sys.symbol); // 0.0080 SYS if precision=4
        uint64_t personal_ram_bytes = personal_ram_weight.amount * state.bytes_per_unit;
        allocated_sys += personal_ram_weight;
        allocated_ram += personal_ram_weight; // RAM allocation

        // 10% of total SYS goes to sysio for RAM
        int64_t sysio_alloc_amount = total_sys_allocation.amount / 10;
        asset sysio_allocation(sysio_alloc_amount, total_sys_allocation.symbol);
        allocated_sys += sysio_allocation;
        allocated_ram += sysio_allocation; // Also RAM allocation since it's for sysio policy

        // Minimal default net/cpu: 0.0500 SYS each for NET and CPU (0.1000 SYS total)
        asset net_cpu_weight(500, state.total_sys.symbol); // 0.0500 SYS
        allocated_sys += (net_cpu_weight + net_cpu_weight);
        allocated_bw += (net_cpu_weight + net_cpu_weight); // CPU/NET allocation

        policies_t policies(get_self(), owner.value);
        auto pol_itr = policies.find(owner.value);

        name sysio_account = "sysio"_n;
        asset zero_asset(0, state.total_sys.symbol);

        if (pol_itr == policies.end()) {
            // Create personal policy
            policies.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.issuer = owner;
                row.net_weight = net_cpu_weight; 
                row.cpu_weight = net_cpu_weight; 
                row.ram_weight = personal_ram_weight; 
                row.bytes_per_unit = state.bytes_per_unit;
                row.time_block = 1; 
            });

            // Create sysio policy for RAM
            policies.emplace(get_self(), [&](auto& row) {
                row.owner = sysio_account;
                row.issuer = owner;
                row.net_weight = zero_asset;
                row.cpu_weight = zero_asset;
                row.ram_weight = sysio_allocation; 
                row.bytes_per_unit = state.bytes_per_unit;
                row.time_block = 1;
            });
        }

        // Owner reslimits
        reslimit_t reslimits(get_self(), owner.value);
        auto res_itr = reslimits.find(owner.value);

        if (res_itr == reslimits.end()) {
            reslimits.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = net_cpu_weight;
                row.cpu_weight = net_cpu_weight;
                row.ram_bytes = personal_ram_bytes;
            });
            set_resource_limits(owner, personal_ram_bytes, net_cpu_weight.amount, net_cpu_weight.amount);
        } else {
            reslimits.modify(res_itr, get_self(), [&](auto& row) {
                row.net_weight += net_cpu_weight;
                row.cpu_weight += net_cpu_weight;
                row.ram_bytes += personal_ram_bytes;
            });
            set_resource_limits(owner, res_itr->ram_bytes, res_itr->net_weight.amount, res_itr->cpu_weight.amount);
        }

        // Sysio reslimit
        reslimit_t sysioreslimit(get_self(), sysio_account.value);
        auto sysio_res_itr = sysioreslimit.find(sysio_account.value);
        check(sysio_res_itr != sysioreslimit.end(), "sysio reslimit does not exist.");

        uint64_t sysio_bytes = sysio_allocation.amount * state.bytes_per_unit;
        sysioreslimit.modify(sysio_res_itr, get_self(), [&](auto& row) {
            row.ram_bytes += sysio_bytes;
        });

        // Update the RAM allocation, sysio is a system account so -1, -1 for net and cpu to maintain unlimited.
        set_resource_limits(sysio_account, sysio_res_itr->ram_bytes, -1, -1);

        // Finally, record the node owner entry with the new fields
        nodeowners.emplace(get_self(), [&](auto& row) {
            row.owner = owner;
            row.tier = tier;
            row.total_sys = total_sys_allocation;
            row.allocated_sys = allocated_sys;
            row.allocated_bw = allocated_bw;
            row.allocated_ram = allocated_ram;
            row.network_gen = state.network_gen;
        });

        // TODO: Notify Council contract if needed
    };

    void roa::addpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint32_t& time_block, const uint8_t& network_gen) {
        // Can only issue policies if you are the issuer.
        require_auth(issuer);

        // Ensure ROA is active
        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not currently active");
        check(network_gen <= state.network_gen, "Invalid network generation.");

        // Ensure issuer is a node owner for the specified network_gen
        nodeowners_t nodeowners(get_self(), network_gen);
        auto node_itr = nodeowners.find(issuer.value);
        check(node_itr != nodeowners.end(), "Only Node Owners can issue policies for this generation.");

        // Validate weights
        check(net_weight.amount >= 0, "NET weight cannot be negative");
        check(cpu_weight.amount >= 0, "CPU weight cannot be negative");
        check(ram_weight.amount >= 0, "RAM weight cannot be negative");

        // If owner is sysio or sysio.* account, no CPU/NET allowed
        bool sysio_acct = is_sysio_account(owner);
        if (sysio_acct) {
            check(net_weight.amount == 0 && cpu_weight.amount == 0, "Cannot allocate CPU/NET to sysio accounts.");
        }

        // Check that at least one is non-zero
        check(!(net_weight.amount == 0 && cpu_weight.amount == 0 && ram_weight.amount == 0), "At least one of NET, CPU, or RAM must be allocated.");

        // Total new allocation
        asset total_new_allocation = net_weight + cpu_weight + ram_weight;

        // Ensure issuer has enough unallocated SYS
        asset free_sys = node_itr->total_sys - node_itr->allocated_sys;
        check(total_new_allocation.amount <= free_sys.amount, "Not enough unallocated SYS for this policy.");

        // Calculate RAM bytes
        int64_t ram_bytes_to_allocate = (int64_t)ram_weight.amount * (int64_t)state.bytes_per_unit;

        // Check if a policy already exists for this owner from this issuer
        policies_t policies(get_self(), issuer.value);
        auto pol_iter = policies.find(owner.value);
        check(pol_iter == policies.end(), "A policy for this owner already exists from this issuer. Use expandpolicy instead.");

        // Update reslimit for the 'owner'
        reslimit_t reslimit(get_self(), owner.value);
        auto res_itr = reslimit.find(owner.value);

        if (res_itr == reslimit.end()) {
            reslimit.emplace(get_self(), [&](auto& row) {
                row.owner = owner;
                row.net_weight = sysio_acct ? asset(0, state.total_sys.symbol) : net_weight;
                row.cpu_weight = sysio_acct ? asset(0, state.total_sys.symbol) : cpu_weight;
                row.ram_bytes = (uint64_t)ram_bytes_to_allocate;
            });
        } else {
            reslimit.modify(res_itr, get_self(), [&](auto& row) {
                if (!sysio_acct) {
                    row.net_weight.amount += net_weight.amount;
                    row.cpu_weight.amount += cpu_weight.amount;
                }
                row.ram_bytes += (uint64_t)ram_bytes_to_allocate;
            });
        }

        // After updating resource limits, set the system resource limits
        auto updated_res_itr = reslimit.find(owner.value);
        if (sysio_acct) {
            // Infinite CPU/NET for sysio accounts
            set_resource_limits(owner, updated_res_itr->ram_bytes, -1, -1);
        } else {
            set_resource_limits(owner, updated_res_itr->ram_bytes, updated_res_itr->net_weight.amount, updated_res_itr->cpu_weight.amount);
        }

        // Add the new policy
        policies.emplace(get_self(), [&](auto& row) {
            row.owner = owner;
            row.issuer = issuer;
            row.net_weight = net_weight;
            row.cpu_weight = cpu_weight;
            row.ram_weight = ram_weight;
            row.bytes_per_unit = state.bytes_per_unit;
            row.time_block = time_block;
        });

        // Update the issuer's allocations
        nodeowners.modify(node_itr, get_self(), [&](auto& row) {
            row.allocated_sys.amount += total_new_allocation.amount;
            row.allocated_bw.amount += (net_weight.amount + cpu_weight.amount);
            row.allocated_ram.amount += ram_weight.amount;
        });
    };

    void roa::expandpolicy(const name& owner, const name& issuer, const asset& net_weight, const asset& cpu_weight, const asset& ram_weight, const uint8_t& network_gen) {
        require_auth(issuer);

        // Ensure issuer is a node owner in the given generation
        nodeowners_t nodeowners(get_self(), network_gen);
        auto node_itr = nodeowners.find(issuer.value);
        check(node_itr != nodeowners.end(), "Only Node Owners can manage policies.");

        // Fetch issuer's policies scoped by issuer
        policies_t policies(get_self(), issuer.value);
        auto pol_itr = policies.find(owner.value);
        check(pol_itr != policies.end(), "You have no policy for this owner.");

        // Validate weights (zero increments allowed)
        check(net_weight.amount >= 0, "NET weight cannot be negative");
        check(cpu_weight.amount >= 0, "CPU weight cannot be negative");
        check(ram_weight.amount >= 0, "RAM weight cannot be negative");

        // Check that at least one of them is non-zero
        if (net_weight.amount == 0 && cpu_weight.amount == 0 && ram_weight.amount == 0) {
            check(false, "At least one of NET, CPU, or RAM must be increased.");
        }

        bool sysio_acct = is_sysio_account(owner);
        if (sysio_acct) {
            // Cannot allocate CPU/NET to sysio accounts
            check(net_weight.amount == 0 && cpu_weight.amount == 0, "Cannot allocate CPU/NET to sysio accounts.");
        }

        // Calculate total new allocation
        asset total_new_allocation = net_weight + cpu_weight + ram_weight;

        // Ensure the issuer has enough unallocated SYS
        asset free_sys = node_itr->total_sys - node_itr->allocated_sys;
        check(total_new_allocation.amount <= free_sys.amount, "Issuer does not have enough unallocated SYS for this policy expansion.");

        // Convert RAM weight to bytes
        int64_t ram_bytes_to_allocate = (int64_t)ram_weight.amount * (int64_t)pol_itr->bytes_per_unit;

        // Update the policy weights
        policies.modify(pol_itr, get_self(), [&](auto& row) {
            if (!sysio_acct) {
                row.net_weight.amount += net_weight.amount;
                row.cpu_weight.amount += cpu_weight.amount;
            }
            row.ram_weight.amount += ram_weight.amount;
        });

        // Update issuer's allocations in nodeowners
        nodeowners.modify(node_itr, get_self(), [&](auto& row) {
            row.allocated_sys.amount += total_new_allocation.amount;
            row.allocated_bw.amount += (net_weight.amount + cpu_weight.amount);
            row.allocated_ram.amount += ram_weight.amount;
        });

        // Update owner's resource limits
        reslimit_t reslimit(get_self(), owner.value);
        auto res_itr = reslimit.find(owner.value);
        check(res_itr != reslimit.end(), "No reslimit found for user.");

        reslimit.modify(res_itr, get_self(), [&](auto& row) {
            if (!sysio_acct) {
                row.net_weight.amount += net_weight.amount;
                row.cpu_weight.amount += cpu_weight.amount;
            }
            row.ram_bytes += (uint64_t)ram_bytes_to_allocate;
        });

        auto updated_res_itr = reslimit.find(owner.value);
        if (sysio_acct) {
            // sysio accounts remain infinite CPU/NET
            set_resource_limits(owner, updated_res_itr->ram_bytes, -1, -1);
        } else {
            set_resource_limits(owner, updated_res_itr->ram_bytes, updated_res_itr->net_weight.amount, updated_res_itr->cpu_weight.amount);
        }
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
        // ---- Native Action, see chain > sysio_contract.cpp in core ---- 
    };

    void roa::initnodereg(const name& owner) {

        require_auth(permission_level{owner, "auth.ext"_n});

        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not active yet");

        nodeowners_t nodeowners(get_self(), state.network_gen);
        auto node_itr = nodeowners.find(owner.value);
        check(node_itr == nodeowners.end(), "This account is already registered.");

        nodeownerreg_t nodereg(get_self(), state.network_gen);
        auto nodereg_itr = nodereg.find(owner.value);
        // Check this one if trx cancelled and they try again, maybe not able to register again
        // Is it better to just check status ? 
        // check(nodereg_itr == nodereg.end(),"Registration already initialized");
        
        // TODO if rejected just modify
        if (nodereg_itr != nodereg.end()) {
            check(nodereg_itr->status == 3, "A registration is already pending or confirmed.");

            //  TODO: Modify row
            nodereg.modify(nodereg_itr,get_self(), [&](auto &row){
                row.status = 0;
                row.trx_id = {};
                row.trx_signature = {};
                row.block_num = 0;
            });

        } else {
            // ToDo -> Add to nodeownerreg table  
            nodereg.emplace(get_self(), [&](auto &row){
                row.owner = owner;
                row.status = 0;
                row.trx_id = {};
                row.trx_signature = {};
                row.tier = 0;
                row.block_num = 0;
            });
        }
    };

    // TODO:  CHECK BYTES -> WNS::BYTES >>>>
    // TODO signature needs to be bytes or sysio::signature ???
    // TODO: Preform check on signature + msgDigest
    void roa::setpending(const name& owner, const uint8_t& tier ,const bytes& trxId, const uint128_t& blockNum, const bytes& sig, const checksum256& msgDigest ) {
        
        require_auth(permission_level{owner, "auth.ext"_n});
    
        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not active yet");

        nodeownerreg_t nodereg(get_self(), state.network_gen);
        auto nodereg_itr = nodereg.find(owner.value);
        // Checks if already started init
        check(nodereg_itr != nodereg.end(),"Registration not initialized yet");

        // TODO: If Tier 4 or 5s need to be able to register, adjust our conditional
        check(tier > 0 && tier <= 3 , "Tier level must be between 1 and 3");

        // TODO =>  
        check(nodereg_itr->status == 0, "Registration status must be 0 ( INTENT ) to set PENDING.");

        // TODO => Check trx id 
        check(trxId.size() == 32, "Invalid Transaction Id, must be length of 32.");

        // TODO: IF we DO need msg_digest, you need to do a check on the signature + msg_digest right here.
        // check_eth_trx(trxId,owner,sig,msgDigest);
        // TODO: THIS IS WHERE WE'D USE VERIFYTRX
        // verifytrx(owner,trxId);

        // TODO => If trx is good update the status and nodeownerreg table 
        nodereg.modify(nodereg_itr,get_self(),[&](auto &row){
            row.status = 1; 
            row.trx_id = trxId;
            row.trx_signature = sig;
            row.tier = tier; 
            row.block_num = blockNum;
        // ! NOTE: might need to add require_receipient(account_name) call to notify validators of a new pending transaction
        });

    };

    // bool roa::verifytrx(const name& owner, const bytes& trxId){

    //     // TODO -> Require authorization for validator !!!
    //     require_auth(permission_level{owner, "auth.ext"_n});

        
    //     roastate_t roastate(get_self(), get_self().value);
    //     auto state = roastate.get();
    //     check(state.is_active, "ROA is not active yet");

    //     nodeowners_t nodeowners(get_self(), state.network_gen);
    //     auto node_itr = nodeowners.find(owner.value);
    //     check(node_itr == nodeowners.end(), "This account is already registered.");

    //     nodeownerreg_t nodereg(get_self(), state.network_gen);
    //     auto nodereg_itr = nodereg.find(owner.value);
    //     check(nodereg_itr != nodereg.end(), "No registration record found for this user.");

    //     // TODO Actions that verifies trx ID !

    //     transaction is approved

    //     //? JUST AN EXAMPLE !! 
    //     bool deposit_okay = (trxId.size() > 0);
    //     if(deposit_okay){
    //         // ACTIONS

    //         finalizereg(owner,nodereg_itr->token_id);
    //         return true;
    //     } else {
    //         // if invalid
    //         // TODO Change status to REJECTED 
    //         nodereg.modify(nodereg_itr, get_self(), [&](auto &row){
    //             row.status = depositState::REJECTED;
    //         });

    //         // TODO Make sure return False
    //         return false;
    //     }

    
    // };
    // TODO -> Make sure validator is checking nodeownerreg table, when status changed to PENDING, validator needs to check the information they provided is matching with the trx they did on Ethereum
    // TODO -> VALIDATOR is going to push this action if the trx is approved or rejected
    // Status:  0-> INTENT / 1-> PENDING  / 2-> CONFIRMED / 3-> REJECTED
    void roa::finalizereg(const name& owner,const uint8_t& status) {


        // TODO -> Require authorization for validator !!!
        require_auth(permission_level{owner, "auth.ext"_n});
        

        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        check(state.is_active, "ROA is not active yet");

        nodeowners_t nodeowners(get_self(), state.network_gen);
        auto node_itr = nodeowners.find(owner.value);
        check(node_itr == nodeowners.end(), "This account is already registered.");

        nodeownerreg_t nodereg(get_self(), state.network_gen);
        auto nodereg_itr = nodereg.find(owner.value);

        // TODO Check if there is a record for this owner
        check(nodereg_itr != nodereg.end(),"No registration record found !");

        // TODO Check status -> Make sure it's pending
        check(nodereg_itr->status == 1, "Registration is not in 1 ( PENDING ) state.");

        //TODO => VERIFY TRANSACTION HERE 

        if(status == 2){
            
            // TODO => Update nodeowners table (add)
            regnodeowner(owner,nodereg_itr->tier);

             // TODO => Update the status here 
            nodereg.modify(nodereg_itr,get_self(),[&](auto &row){
                row.status = 2;
            });

        } else {
            nodereg.modify(nodereg_itr,get_self(),[&](auto &row){
                row.status = 3;
            });
        }

    
    };



    // ---- Private Helper Function ----
    asset roa::get_allocation_for_tier(uint8_t tier) {
        // Retrieve the current roastate
        roastate_t roastate(get_self(), get_self().value);
        auto state = roastate.get();
        
        // Ensure the contract is active
        check(state.is_active, "Contract not active yet.");

        int64_t total_amount = state.total_sys.amount;
        int64_t allocation_amount = 0;

        switch (tier) {
            case 1:
                // T1 fraction: 4/100
                // Add 50 to round to nearest integer
                allocation_amount = (total_amount * 4 + 50) / 100;
                break;
            case 2:
                // T2 fraction: 15/10,000 = 0.0015
                // Add 5,000 to round
                allocation_amount = (total_amount * 15 + 5000) / 10000;
                break;
            case 3:
                // T3 fraction: 3/100,000 = 0.00003
                // Add 50,000 to round
                allocation_amount = (total_amount * 3 + 50000) / 100000;
                break;
            default:
                check(false, "Invalid tier");
        }

        return asset(allocation_amount, state.total_sys.symbol);
    }
} // namespace roa

// SYSIO_DISPATCH(sysio::roa, (reducepolicy));

    // TODO bytes or roa::bytes || Added from settlewns
//     void roa::check_eth_trx(const bytes &trxId, const name& signer, const sysio::signature &sig, const checksum256 &msgDigest) {
   
//     // Make sure transaction id is the proper length.
//     check(trx_id.size() == 32, "Transaction id must be 32 bytes long.");

//     // Verify the signature passed was indeed signed by the private key associated with foundTrx->to. And that all parameters match our auth.msg's links table.
//     sysio::public_key pub_key = sysio::recover_key(msgDigest, sig);

//     // Get reference to links table and find the row associated with foundTrx->to.
//     links_t links("auth.msg"_n, "auth.msg"_n.value);
//     auto linkIndex = links.get_index<"byname"_n>();
//     auto foundLink = linkIndex.find(signer.value);

//     check(foundLink != linkIndex.end(), "No link found for user.");

//     const bytes recovered_key_bytes = pub_key_bytes(pub_key);
//     // Compare the recovered key to the public key associated with the account.
//     std::string recovered_str(recovered_key_bytes.begin(), recovered_key_bytes.end());
//     std::string found_str(foundLink->comp_key.begin(), foundLink->comp_key.end());

//     check(foundLink->comp_key == recovered_key_bytes, "Signature does not match the public key associated with the account. "+found_str+" vs " + recovered_str);
// }

    //TODO Added from settlewns
    // bytes roa::pub_key_bytes(const sysio::public_key &pubkey) {
    // return std::visit([](auto&& key) -> std::vector<char> {
    //     using T = std::decay_t<decltype(key)>;
    //     if constexpr (std::is_same_v<T, sysio::ecc_public_key>) {
    //         return std::vector<char>(key.begin(), key.end());
    //     } else {
    //         check(false, "Unsupported public key type.");
    //         return {};
    //     }
    // }, pubkey);
    // }
