#pragma once

#include <sysio/action.hpp>
#include <sysio/crypto.hpp>
#include <sysio/sysio.hpp>
#include <sysio/fixed_bytes.hpp>
#include <sysio/privileged.hpp>
#include <sysio/producer_schedule.hpp>

namespace sysiobios {

   using sysio::action_wrapper;
   using sysio::check;
   using sysio::checksum256;
   using sysio::ignore;
   using sysio::name;
   using sysio::permission_level;
   using sysio::public_key;

   struct permission_level_weight {
      permission_level  permission;
      uint16_t          weight;

      // explicit serialization macro is not necessary, used here only to improve compilation time
      SYSLIB_SERIALIZE( permission_level_weight, (permission)(weight) )
   };

   struct key_weight {
      sysio::public_key  key;
      uint16_t           weight;

      // explicit serialization macro is not necessary, used here only to improve compilation time
      SYSLIB_SERIALIZE( key_weight, (key)(weight) )
   };

   struct wait_weight {
      uint32_t           wait_sec;
      uint16_t           weight;

      // explicit serialization macro is not necessary, used here only to improve compilation time
      SYSLIB_SERIALIZE( wait_weight, (wait_sec)(weight) )
   };

   struct authority {
      uint32_t                              threshold = 0;
      std::vector<key_weight>               keys;
      std::vector<permission_level_weight>  accounts;
      std::vector<wait_weight>              waits;

      // explicit serialization macro is not necessary, used here only to improve compilation time
      SYSLIB_SERIALIZE( authority, (threshold)(keys)(accounts)(waits) )
   };

   struct block_header {
      uint32_t                                  timestamp;
      name                                      producer;
      uint16_t                                  confirmed = 0;
      checksum256                               previous;
      checksum256                               transaction_mroot;
      checksum256                               action_mroot;
      uint32_t                                  schedule_version = 0;
      std::optional<sysio::producer_schedule>   new_producers;

      // explicit serialization macro is not necessary, used here only to improve compilation time
      SYSLIB_SERIALIZE(block_header, (timestamp)(producer)(confirmed)(previous)(transaction_mroot)(action_mroot)
                                     (schedule_version)(new_producers))
   };

   /**
    * The `sysio.bios` is the first sample of system contract provided by `block.one` through the SYSIO platform. It is a minimalist system contract because it only supplies the actions that are absolutely critical to bootstrap a chain and nothing more. This allows for a chain agnostic approach to bootstrapping a chain.
    * 
    * Just like in the `sysio.system` sample contract implementation, there are a few actions which are not implemented at the contract level (`newaccount`, `updateauth`, `deleteauth`, `linkauth`, `unlinkauth`, `setabi`, `setcode`), they are just declared in the contract so they will show in the contract's ABI and users will be able to push those actions to the chain via the account holding the `sysio.system` contract, but the implementation is at the SYSIO core level. They are referred to as SYSIO native actions.
    */
   class [[sysio::contract("sysio.bios")]] bios : public sysio::contract {
      public:
         using contract::contract;
         /**
          * New account action, called after a new account is created. This code enforces resource-limits rules
          * for new accounts as well as new account naming conventions.
          *
          * 1. accounts cannot contain '.' symbols which forces all acccounts to be 12
          * characters long without '.' until a future account auction process is implemented
          * which prevents name squatting.
          *
          * 2. new accounts must stake a minimal number of tokens (as set in system parameters)
          * therefore, this method will execute an inline buyram from receiver for newacnt in
          * an amount equal to the current new account creation fee.
          */
         [[sysio::action]]
         void newaccount( name             creator,
                          name             name,
                          ignore<authority> owner,
                          ignore<authority> active){}
         /**
          * Update authorization action updates pemission for an account.
          *
          * @param account - the account for which the permission is updated,
          * @param pemission - the permission name which is updated,
          * @param parem - the parent of the permission which is updated,
          * @param aut - the json describing the permission authorization.
          */
         [[sysio::action]]
         void updateauth(  ignore<name>  account,
                           ignore<name>  permission,
                           ignore<name>  parent,
                           ignore<authority> auth ) {}

         /**
          * Delete authorization action deletes the authorization for an account's permission.
          *
          * @param account - the account for which the permission authorization is deleted,
          * @param permission - the permission name been deleted.
          */
         [[sysio::action]]
         void deleteauth( ignore<name>  account,
                          ignore<name>  permission ) {}

         /**
          * Link authorization action assigns a specific action from a contract to a permission you have created. Five system
          * actions can not be linked `updateauth`, `deleteauth`, `linkauth`, and `unlinkauth`.
          * This is useful because when doing authorization checks, the SYSIO based blockchain starts with the
          * action needed to be authorized (and the contract belonging to), and looks up which permission
          * is needed to pass authorization validation. If a link is set, that permission is used for authoraization
          * validation otherwise then active is the default, with the exception of `sysio.any`.
          * `sysio.any` is an implicit permission which exists on every account; you can link actions to `sysio.any`
          * and that will make it so linked actions are accessible to any permissions defined for the account.
          *
          * @param account - the permission's owner to be linked and the payer of the RAM needed to store this link,
          * @param code - the owner of the action to be linked,
          * @param type - the action to be linked,
          * @param requirement - the permission to be linked.
          */
         [[sysio::action]]
         void linkauth(  ignore<name>    account,
                         ignore<name>    code,
                         ignore<name>    type,
                         ignore<name>    requirement  ) {}

         /**
          * Unlink authorization action it's doing the reverse of linkauth action, by unlinking the given action.
          *
          * @param account - the owner of the permission to be unlinked and the receiver of the freed RAM,
          * @param code - the owner of the action to be unlinked,
          * @param type - the action to be unlinked.
          */
         [[sysio::action]]
         void unlinkauth( ignore<name>  account,
                          ignore<name>  code,
                          ignore<name>  type ) {}

         /**
          * Set code action sets the contract code for an account.
          *
          * @param account - the account for which to set the contract code.
          * @param vmtype - reserved, set it to zero.
          * @param vmversion - reserved, set it to zero.
          * @param code - the code content to be set, in the form of a blob binary..
          */
         [[sysio::action]]
         void setcode( name account, uint8_t vmtype, uint8_t vmversion, const std::vector<char>& code ) {}

         /**
          * Set abi action sets the abi for contract identified by `account` name. Creates an entry in the abi_hash_table
          * index, with `account` name as key, if it is not already present and sets its value with the abi hash.
          * Otherwise it is updating the current abi hash value for the existing `account` key.
          *
          * @param account - the name of the account to set the abi for
          * @param abi     - the abi hash represented as a vector of characters
          */
         [[sysio::action]]
         void setabi( name account, const std::vector<char>& abi );

         /**
          * Set privilege action allows to set privilege status for an account (turn it on/off).
          * @param account - the account to set the privileged status for.
          * @param is_priv - 0 for false, > 0 for true.
          */
         [[sysio::action]]
         void setpriv( name account, uint8_t is_priv );

         /**
          * Sets the resource limits of an account
          *
          * @param account - name of the account whose resource limit to be set
          * @param ram_bytes - ram limit in absolute bytes
          * @param net_weight - fractionally proportionate net limit of available resources based on (weight / total_weight_of_all_accounts)
          * @param cpu_weight - fractionally proportionate cpu limit of available resources based on (weight / total_weight_of_all_accounts)
          */
         [[sysio::action]]
         void setalimits( name account, int64_t ram_bytes, int64_t net_weight, int64_t cpu_weight );

         /**
          * Set producers action, sets a new list of active producers, by proposing a schedule change, once the block that
          * contains the proposal becomes irreversible, the schedule is promoted to "pending"
          * automatically. Once the block that promotes the schedule is irreversible, the schedule will
          * become "active".
          *
          * @param schedule - New list of active producers to set
          */
         [[sysio::action]]
         void setprods( const std::vector<sysio::producer_authority>& schedule );

         /**
          * Set params action, sets the blockchain parameters. By tuning these parameters, various degrees of customization can be achieved.
          *
          * @param params - New blockchain parameters to set
          */
         [[sysio::action]]
         void setparams( const sysio::blockchain_parameters& params );

         /**
          * Require authorization action, checks if the account name `from` passed in as param has authorization to access
          * current action, that is, if it is listed in the action’s allowed permissions vector.
          *
          * @param from - the account name to authorize
          */
         [[sysio::action]]
         void reqauth( name from );

         /**
          * Activate action, activates a protocol feature
          *
          * @param feature_digest - hash of the protocol feature to activate.
          */
         [[sysio::action]]
         void activate( const sysio::checksum256& feature_digest );

         /**
          * Require activated action, asserts that a protocol feature has been activated
          *
          * @param feature_digest - hash of the protocol feature to check for activation.
          */
         [[sysio::action]]
         void reqactivated( const sysio::checksum256& feature_digest );

         struct [[sysio::table]] abi_hash {
            name              owner;
            checksum256       hash;
            uint64_t primary_key()const { return owner.value; }

            SYSLIB_SERIALIZE( abi_hash, (owner)(hash) )
         };

         typedef sysio::multi_index< "abihash"_n, abi_hash > abi_hash_table;

         using newaccount_action = action_wrapper<"newaccount"_n, &bios::newaccount>;
         using updateauth_action = action_wrapper<"updateauth"_n, &bios::updateauth>;
         using deleteauth_action = action_wrapper<"deleteauth"_n, &bios::deleteauth>;
         using linkauth_action = action_wrapper<"linkauth"_n, &bios::linkauth>;
         using unlinkauth_action = action_wrapper<"unlinkauth"_n, &bios::unlinkauth>;
         using setcode_action = action_wrapper<"setcode"_n, &bios::setcode>;
         using setabi_action = action_wrapper<"setabi"_n, &bios::setabi>;
         using setpriv_action = action_wrapper<"setpriv"_n, &bios::setpriv>;
         using setalimits_action = action_wrapper<"setalimits"_n, &bios::setalimits>;
         using setprods_action = action_wrapper<"setprods"_n, &bios::setprods>;
         using setparams_action = action_wrapper<"setparams"_n, &bios::setparams>;
         using reqauth_action = action_wrapper<"reqauth"_n, &bios::reqauth>;
         using activate_action = action_wrapper<"activate"_n, &bios::activate>;
         using reqactivated_action = action_wrapper<"reqactivated"_n, &bios::reqactivated>;
   };
}
