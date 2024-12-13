#pragma once

#include <sysio/asset.hpp>
#include <sysio/sysio.hpp>
#include <sysio/name.hpp>

using sysio::action_wrapper;
using sysio::asset;
using sysio::name;

/**
 * The action `powupresult` is a no-op.
 * It is added as an inline convenience action to `powerup` reservation.
 * This inline convenience action does not have any effect, however,
 * its data includes the result of the parent action and appears in its trace.
 */
class [[sysio::contract("powup.results")]] powup_results : sysio::contract {
   public:

      using sysio::contract::contract;

      /**
       * powupresult action.
       *
       * @param fee       - powerup fee amount
       * @param powup_net - amount of powup NET tokens
       * @param powup_cpu - amount of powup CPU tokens
       */
      [[sysio::action]]
      void powupresult( const asset& fee, const int64_t powup_net, const int64_t powup_cpu );

      using powupresult_action  = action_wrapper<"powupresult"_n,  &powup_results::powupresult>;
};
