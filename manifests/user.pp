# @summary Manage a user configuation for timekpr
#
# @param user Username to manage limits for
#
# @example Manage a user with some limts
#   timekpr::user{'eric':
#   
#
define timekpr::user (
  String[1] $user = $title,
) {
  include timekpr
}
