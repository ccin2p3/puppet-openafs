#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::client
#
# This class is meant to be called from openafs::resource::client
# It ensure the package is installed
#
class openafs::resource::client::install (
  $ensure = 'present'
)
{
  case $ensure {
    present: {
      $package_ensure = present
    }
    absent: {
      $package_ensure = purged
    }
    default: {
      fail("Unsupported ensure value `${ensure}`")
    }
  }
  package { $openafs::resource::client::params::package_name:
    ensure    => $package_ensure,
  }
}
