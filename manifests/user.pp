# @summary Manage a user configuation for timekpr
#
# @param user Username to manage limits for
# @param defaults Hours and minutes that access is permitted
# @param days Hours and minutes per day to be merged with the default
#
# @example Manage a user with some limts
#   timekpr::user{'eric':
#     defaults = {
#      '9'  => [30,59],
#      '10' => [0,59]
#      '13' => [0,59]
#      '14' => [0,59]
#      '15' => [0,59]
#      '17' => [0,59]
#      '18' => [0,30]
#    },
#    days => {
#      'friday' => {  # no school tomorrow
#        '18' => [0,59]
#        '19' => [0,30],
#      }
#    },
#  }
#
define timekpr::user (
  String[1] $user = $title,
  Hash $defaults = {},
  Hash[Enum['monday','tuesday','wednesday','thursday','friday','saturday','sunday'],Hash,0,6] $days = {}
) {
  include timekpr

  $_days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'].map | $_day | {
    if $_day in $days {
      $_result = { $_day => Hash($defaults + $days[$_day]) }
    } else {
      $_result = { $_day => $defaults }
    }
    $_result
  }.reduce | $_memo, $_kv | { $_memo + $_kv }

  file { "/var/lib/timekpr/conf/timekpr.${user}.conf":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    #content  => stdlib::to_yaml($_days),
    content => epp('timekpr/timekpr.user.conf.epp', {
        user => $user,
        days => $_days,
    }),
  }
}
