#include <sysio.boot/sysio.boot.hpp>
#include <sysio/privileged.hpp>

namespace sysioboot {

void boot::onerror( ignore<uint128_t>, ignore<std::vector<char>> ) {
   check( false, "the onerror action cannot be called directly" );
}

void boot::activate( const sysio::checksum256& feature_digest ) {
   require_auth( get_self() );
   sysio::preactivate_feature( feature_digest );
}

void boot::reqactivated( const sysio::checksum256& feature_digest ) {
   check( sysio::is_feature_activated( feature_digest ), "protocol feature is not activated" );
}

}
