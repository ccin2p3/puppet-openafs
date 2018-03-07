#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::server
#
# This class is meant to be called from openafs::resource::server
# It ensure the package is installed
#
class openafs::resource::server::install (
  $ensure = 'present'
)
{
  include ::openafs::resource::server
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
  package { $openafs::resource::server::package_name:
    ensure    => $package_ensure,
  }
}
