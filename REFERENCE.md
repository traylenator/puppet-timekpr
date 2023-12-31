# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`timekpr`](#timekpr): Install and set up timekpr-next package

#### Private Classes

* `timekpr::install`: Install timekpr package

### Defined types

* [`timekpr::user`](#timekpr--user): Manage a user configuation for timekpr

## Classes

### <a name="timekpr"></a>`timekpr`

Install and set up timekpr-next package

* **See also**
  * timekpr-next
    * https://mjasnik.gitlab.io/timekpr-next/

#### Parameters

The following parameters are available in the `timekpr` class:

* [`package`](#-timekpr--package)

##### <a name="-timekpr--package"></a>`package`

Data type: `String[1]`

Name of timekpr-next package

Default value: `'timekpr-next'`

## Defined types

### <a name="timekpr--user"></a>`timekpr::user`

}

#### Examples

##### Manage a user with some limts

```puppet
timekpr::user{'eric':
  default_hours = {
   '9'             => [30,59],
   '10'            => [0,59]
   '13'            => [0,59]
   '14'            => [0,59]
   '15'            => [0,59]
   '17'            => [0,59]
   '18'            => [0,30]
 },
 day_hours         => {
   'friday'        => {  # no school tomorrow
     '18'          => [0,59]
     '19'          => [0,30],
   }
 },
 default_limit_sec => 3 * 60,
 day_limit_sec     => {
   'saturday'      => 5 * 60,
 }
```

#### Parameters

The following parameters are available in the `timekpr::user` defined type:

* [`user`](#-timekpr--user--user)
* [`default_hours`](#-timekpr--user--default_hours)
* [`day_hours`](#-timekpr--user--day_hours)
* [`default_limit_secs`](#-timekpr--user--default_limit_secs)
* [`day_limit_secs`](#-timekpr--user--day_limit_secs)

##### <a name="-timekpr--user--user"></a>`user`

Data type: `String[1]`

Username to manage limits for

Default value: `$title`

##### <a name="-timekpr--user--default_hours"></a>`default_hours`

Data type: `Hash`

Hours and minutes that access is permitted

Default value:

```puppet
{
    '0' => [0,59],
    '1' => [0,59],
    '2' => [0,59],
    '3' => [0,59],
    '4' => [0,59],
    '5' => [0,59],
    '6' => [0,59],
    '7' => [0,59],
    '8' => [0,59],
    '9' => [0,59],
    '10' => [0,59],
    '11' => [0,59],
    '13' => [0,59],
    '14' => [0,59],
    '15' => [0,59],
    '16' => [0,59],
    '17' => [0,59],
    '18' => [0,59],
    '19' => [0,59],
    '20' => [0,59],
    '21' => [0,59],
    '23' => [0,59],
  }
```

##### <a name="-timekpr--user--day_hours"></a>`day_hours`

Data type: `Hash[Enum['monday','tuesday','wednesday','thursday','friday','saturday','sunday'],Hash,0,6]`

Hours and minutes per day to be merged with the default

Default value: `{}`

##### <a name="-timekpr--user--default_limit_secs"></a>`default_limit_secs`

Data type: `Integer[0]`

Default max seconds per day

Default value: `86400`

##### <a name="-timekpr--user--day_limit_secs"></a>`day_limit_secs`

Data type: `Hash[Enum['monday','tuesday','wednesday','thursday','friday','saturday','sunday'],Integer[0]]`

Per day max seconds per day

Default value: `{}`

