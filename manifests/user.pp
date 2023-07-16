# @summary Manage a user configuation for timekpr
#
# @param user Username to manage limits for
# @param defaults Hours and minutes that access is permitted
# @param days Hours and minutes per day to be merged with the default
#
# @example Manage a user with some limts
#   timekpr::user{'eric':
#     default_hours = {
#      '9'  => [30,59],
#      '10' => [0,59]
#      '13' => [0,59]
#      '14' => [0,59]
#      '15' => [0,59]
#      '17' => [0,59]
#      '18' => [0,30]
#    },
#    day_hours => {
#      'friday' => {  # no school tomorrow
#        '18' => [0,59]
#        '19' => [0,30],
#      }
#    },
#  }
#
define timekpr::user (
  String[1] $user = $title,
  Hash $default_hours = {
    "0" => [0,59],
    "1" => [0,59],
    "2" => [0,59],
    "3" => [0,59],
    "4" => [0,59],
    "5" => [0,59],
    "6" => [0,59],
    "7" => [0,59],
    "8" => [0,59],
    "9" => [0,59],
    "10" => [0,59],
    "11" => [0,59],
    "13" => [0,59],
    "15" => [0,59],
    "16" => [0,59],
    "16" => [0,59],
    "17" => [0,59],
    "18" => [0,59],
    "19" => [0,59],
    "20" => [0,59],
    "21" => [0,59],
    "23" => [0,59],
  },
  Hash[Enum['monday','tuesday','wednesday','thursday','friday','saturday','sunday'],Hash,0,6] $day_hours = {}
) {
  include timekpr

  $_days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday'].map | $_day | {
    if $_day in $day_hours {
      $_result = { $_day => Hash($default_hours + $day_hours[$_day]) }
    } else {
      $_result = { $_day => $default_hours }
    }
    $_result
  }.reduce | $_memo, $_kv | { $_memo + $_kv }

  file { "/var/lib/timekpr/config/timekpr.${user}.conf":
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
