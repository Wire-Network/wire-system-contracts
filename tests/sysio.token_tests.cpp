#include <boost/test/unit_test.hpp>
#include <sysio/testing/tester.hpp>
#include <sysio/chain/abi_serializer.hpp>
#include "sysio.system_tester.hpp"

#include <fc/variant_object.hpp>

using namespace sysio::testing;
using namespace sysio;
using namespace sysio::chain;
using namespace sysio::testing;
using namespace fc;
using namespace std;

using mvo = fc::mutable_variant_object;

class sysio_token_tester : public tester {
public:

   sysio_token_tester() {
      produce_blocks( 2 );

      create_accounts( { "alice"_n, "bob"_n, "carol"_n, "sysio.token"_n } );
      produce_blocks( 2 );

      set_code( "sysio.token"_n, contracts::token_wasm() );
      set_abi( "sysio.token"_n, contracts::token_abi().data() );

      produce_blocks();

      const auto& accnt = control->db().get<account_object,by_name>( "sysio.token"_n );
      abi_def abi;
      BOOST_REQUIRE_EQUAL(abi_serializer::to_abi(accnt.abi, abi), true);
      abi_ser.set_abi(abi, abi_serializer::create_yield_function(abi_serializer_max_time));
   }

   action_result push_action( const account_name& signer, const action_name &name, const variant_object &data ) {
      string action_type_name = abi_ser.get_action_type(name);

      action act;
      act.account = "sysio.token"_n;
      act.name    = name;
      act.data    = abi_ser.variant_to_binary( action_type_name, data, abi_serializer::create_yield_function(abi_serializer_max_time) );

      return base_tester::push_action( std::move(act), signer.to_uint64_t() );
   }

   fc::variant get_stats( const string& symbolname )
   {
      auto symb = sysio::chain::symbol::from_string(symbolname);
      auto symbol_code = symb.to_symbol_code().value;
      vector<char> data = get_row_by_account( "sysio.token"_n, name(symbol_code), "stat"_n, account_name(symbol_code) );
      return data.empty() ? fc::variant() : abi_ser.binary_to_variant( "currency_stats", data, abi_serializer::create_yield_function(abi_serializer_max_time) );
   }

   fc::variant get_account( account_name acc, const string& symbolname)
   {
      auto symb = sysio::chain::symbol::from_string(symbolname);
      auto symbol_code = symb.to_symbol_code().value;
      vector<char> data = get_row_by_account( "sysio.token"_n, acc, "accounts"_n, account_name(symbol_code) );
      return data.empty() ? fc::variant() : abi_ser.binary_to_variant( "account", data, abi_serializer::create_yield_function(abi_serializer_max_time) );
   }

   action_result create( account_name issuer,
                         asset        maximum_supply ) {

      return push_action( "sysio.token"_n, "create"_n, mvo()
           ( "issuer", issuer)
           ( "maximum_supply", maximum_supply)
      );
   }

   action_result issue( account_name issuer, asset quantity, string memo ) {
      return push_action( issuer, "issue"_n, mvo()
           ( "to", issuer)
           ( "quantity", quantity)
           ( "memo", memo)
      );
   }

   action_result retire( account_name issuer, asset quantity, string memo ) {
      return push_action( issuer, "retire"_n, mvo()
           ( "quantity", quantity)
           ( "memo", memo)
      );

   }

   action_result transfer( account_name from,
                  account_name to,
                  asset        quantity,
                  string       memo ) {
      return push_action( from, "transfer"_n, mvo()
           ( "from", from)
           ( "to", to)
           ( "quantity", quantity)
           ( "memo", memo)
      );
   }

   action_result open( account_name owner,
                       const string& symbolname,
                       account_name ram_payer    ) {
      return push_action( ram_payer, "open"_n, mvo()
           ( "owner", owner )
           ( "symbol", symbolname )
           ( "ram_payer", ram_payer )
      );
   }

   action_result close( account_name owner,
                        const string& symbolname ) {
      return push_action( owner, "close"_n, mvo()
           ( "owner", owner )
           ( "symbol", symbolname )
      );
   }

   abi_serializer abi_ser;
};

BOOST_AUTO_TEST_SUITE(sysio_token_tests)

BOOST_FIXTURE_TEST_CASE( create_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000.000 TKN"));
   auto stats = get_stats("3,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "0.000 TKN")
      ("max_supply", "1000.000 TKN")
      ("issuer", "alice")
   );
   produce_blocks(1);

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( create_negative_max_supply, sysio_token_tester ) try {

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "max-supply must be positive" ),
      create( "alice"_n, asset::from_string("-1000.000 TKN"))
   );

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( symbol_already_exists, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("100 TKN"));
   auto stats = get_stats("0,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "0 TKN")
      ("max_supply", "100 TKN")
      ("issuer", "alice")
   );
   produce_blocks(1);

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "token with symbol already exists" ),
                        create( "alice"_n, asset::from_string("100 TKN"))
   );

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( create_max_supply, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("4611686018427387903 TKN"));
   auto stats = get_stats("0,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "0 TKN")
      ("max_supply", "4611686018427387903 TKN")
      ("issuer", "alice")
   );
   produce_blocks(1);

   asset max(10, symbol(SY(0, NKT)));
   share_type amount = 4611686018427387904;
   static_assert(sizeof(share_type) <= sizeof(asset), "asset changed so test is no longer valid");
   static_assert(std::is_trivially_copyable<asset>::value, "asset is not trivially copyable");
   memcpy(&max, &amount, sizeof(share_type)); // hack in an invalid amount

   BOOST_CHECK_EXCEPTION( create( "alice"_n, max) , asset_type_exception, [](const asset_type_exception& e) {
      return expect_assert_message(e, "magnitude of asset amount must be less than 2^62");
   });


} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( create_max_decimals, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1.000000000000000000 TKN"));
   auto stats = get_stats("18,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "0.000000000000000000 TKN")
      ("max_supply", "1.000000000000000000 TKN")
      ("issuer", "alice")
   );
   produce_blocks(1);

   asset max(10, symbol(SY(0, NKT)));
   //1.0000000000000000000 => 0x8ac7230489e80000L
   share_type amount = 0x8ac7230489e80000L;
   static_assert(sizeof(share_type) <= sizeof(asset), "asset changed so test is no longer valid");
   static_assert(std::is_trivially_copyable<asset>::value, "asset is not trivially copyable");
   memcpy(&max, &amount, sizeof(share_type)); // hack in an invalid amount

   BOOST_CHECK_EXCEPTION( create( "alice"_n, max) , asset_type_exception, [](const asset_type_exception& e) {
      return expect_assert_message(e, "magnitude of asset amount must be less than 2^62");
   });

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( issue_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000.000 TKN"));
   produce_blocks(1);

   issue( "alice"_n, asset::from_string("500.000 TKN"), "hola" );

   auto stats = get_stats("3,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "500.000 TKN")
      ("max_supply", "1000.000 TKN")
      ("issuer", "alice")
   );

   auto alice_balance = get_account("alice"_n, "3,TKN");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "500.000 TKN")
   );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "quantity exceeds available supply" ),
                        issue( "alice"_n, asset::from_string("500.001 TKN"), "hola" )
   );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "must issue positive quantity" ),
                        issue( "alice"_n, asset::from_string("-1.000 TKN"), "hola" )
   );

   BOOST_REQUIRE_EQUAL( success(),
                        issue( "alice"_n, asset::from_string("1.000 TKN"), "hola" )
   );


} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( retire_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000.000 TKN"));
   produce_blocks(1);

   BOOST_REQUIRE_EQUAL( success(), issue( "alice"_n, asset::from_string("500.000 TKN"), "hola" ) );

   auto stats = get_stats("3,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "500.000 TKN")
      ("max_supply", "1000.000 TKN")
      ("issuer", "alice")
   );

   auto alice_balance = get_account("alice"_n, "3,TKN");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "500.000 TKN")
   );

   BOOST_REQUIRE_EQUAL( success(), retire( "alice"_n, asset::from_string("200.000 TKN"), "hola" ) );
   stats = get_stats("3,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "300.000 TKN")
      ("max_supply", "1000.000 TKN")
      ("issuer", "alice")
   );
   alice_balance = get_account("alice"_n, "3,TKN");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "300.000 TKN")
   );

   //should fail to retire more than current supply
   BOOST_REQUIRE_EQUAL( wasm_assert_msg("overdrawn balance"), retire( "alice"_n, asset::from_string("500.000 TKN"), "hola" ) );

   BOOST_REQUIRE_EQUAL( success(), transfer( "alice"_n, "bob"_n, asset::from_string("200.000 TKN"), "hola" ) );
   //should fail to retire since tokens are not on the issuer's balance
   BOOST_REQUIRE_EQUAL( wasm_assert_msg("overdrawn balance"), retire( "alice"_n, asset::from_string("300.000 TKN"), "hola" ) );
   //transfer tokens back
   BOOST_REQUIRE_EQUAL( success(), transfer( "bob"_n, "alice"_n, asset::from_string("200.000 TKN"), "hola" ) );

   BOOST_REQUIRE_EQUAL( success(), retire( "alice"_n, asset::from_string("300.000 TKN"), "hola" ) );
   stats = get_stats("3,TKN");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "0.000 TKN")
      ("max_supply", "1000.000 TKN")
      ("issuer", "alice")
   );
   alice_balance = get_account("alice"_n, "3,TKN");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "0.000 TKN")
   );

   //trying to retire tokens with zero supply
   BOOST_REQUIRE_EQUAL( wasm_assert_msg("overdrawn balance"), retire( "alice"_n, asset::from_string("1.000 TKN"), "hola" ) );

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( transfer_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000 CERO"));
   produce_blocks(1);

   issue( "alice"_n, asset::from_string("1000 CERO"), "hola" );

   auto stats = get_stats("0,CERO");
   REQUIRE_MATCHING_OBJECT( stats, mvo()
      ("supply", "1000 CERO")
      ("max_supply", "1000 CERO")
      ("issuer", "alice")
   );

   auto alice_balance = get_account("alice"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "1000 CERO")
   );

   transfer( "alice"_n, "bob"_n, asset::from_string("300 CERO"), "hola" );

   alice_balance = get_account("alice"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "700 CERO")
   );

   auto bob_balance = get_account("bob"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( bob_balance, mvo()
      ("balance", "300 CERO")
   );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "overdrawn balance" ),
      transfer( "alice"_n, "bob"_n, asset::from_string("701 CERO"), "hola" )
   );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "must transfer positive quantity" ),
      transfer( "alice"_n, "bob"_n, asset::from_string("-1000 CERO"), "hola" )
   );


} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( open_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000 CERO"));

   auto alice_balance = get_account("alice"_n, "0,CERO");
   BOOST_REQUIRE_EQUAL(true, alice_balance.is_null() );
   BOOST_REQUIRE_EQUAL( wasm_assert_msg("tokens can only be issued to issuer account"),
                        push_action( "alice"_n, "issue"_n, mvo()
                                     ( "to",       "bob")
                                     ( "quantity", asset::from_string("1000 CERO") )
                                     ( "memo",     "") ) );
   BOOST_REQUIRE_EQUAL( success(), issue( "alice"_n, asset::from_string("1000 CERO"), "issue" ) );

   alice_balance = get_account("alice"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "1000 CERO")
   );

   auto bob_balance = get_account("bob"_n, "0,CERO");
   BOOST_REQUIRE_EQUAL(true, bob_balance.is_null() );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg("owner account does not exist"),
                        open( "nonexistent"_n, "0,CERO", "alice"_n ) );
   BOOST_REQUIRE_EQUAL( success(),
                        open( "bob"_n,         "0,CERO", "alice"_n ) );

   bob_balance = get_account("bob"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( bob_balance, mvo()
      ("balance", "0 CERO")
   );

   BOOST_REQUIRE_EQUAL( success(), transfer( "alice"_n, "bob"_n, asset::from_string("200 CERO"), "hola" ) );

   bob_balance = get_account("bob"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( bob_balance, mvo()
      ("balance", "200 CERO")
   );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "symbol does not exist" ),
                        open( "carol"_n, "0,INVALID", "alice"_n ) );

   BOOST_REQUIRE_EQUAL( wasm_assert_msg( "symbol precision mismatch" ),
                        open( "carol"_n, "1,CERO", "alice"_n ) );

} FC_LOG_AND_RETHROW()

BOOST_FIXTURE_TEST_CASE( close_tests, sysio_token_tester ) try {

   auto token = create( "alice"_n, asset::from_string("1000 CERO"));

   auto alice_balance = get_account("alice"_n, "0,CERO");
   BOOST_REQUIRE_EQUAL(true, alice_balance.is_null() );

   BOOST_REQUIRE_EQUAL( success(), issue( "alice"_n, asset::from_string("1000 CERO"), "hola" ) );

   alice_balance = get_account("alice"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "1000 CERO")
   );

   BOOST_REQUIRE_EQUAL( success(), transfer( "alice"_n, "bob"_n, asset::from_string("1000 CERO"), "hola" ) );

   alice_balance = get_account("alice"_n, "0,CERO");
   REQUIRE_MATCHING_OBJECT( alice_balance, mvo()
      ("balance", "0 CERO")
   );

   BOOST_REQUIRE_EQUAL( success(), close( "alice"_n, "0,CERO" ) );
   alice_balance = get_account("alice"_n, "0,CERO");
   BOOST_REQUIRE_EQUAL(true, alice_balance.is_null() );

} FC_LOG_AND_RETHROW()

BOOST_AUTO_TEST_SUITE_END()
