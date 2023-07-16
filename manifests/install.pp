# @summary  Install timekpr package
# @api private
#
class timekpr::install (
  String[1] $package = 'timekpr-next',
) {
  package { 'timekpr-next':
    ensure => installed,
  }
}
