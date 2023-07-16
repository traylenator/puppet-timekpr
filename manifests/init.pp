# @summary Install and set up timekpr-next package
# @see timekpr-next https://mjasnik.gitlab.io/timekpr-next/
#
# @param package Name of timekpr-next package
#
class timekpr (
  String[1] $package = 'timekpr-next',
) {
  include timekpr::install
}
