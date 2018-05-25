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
  Enum['present','absent'] $ensure = 'present',
)
{
  include ::openafs::resource::client
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
  package { $openafs::resource::client::package_name:
    ensure    => $package_ensure,
  }
  if $openafs::resource::client::force_current_kernel_module_install and $openafs::resource::client::kernel_module_package_prefix and $facts['kernelrelease'] =~ /^\d+\.\d+\.\d+\-(\d+)/ {
    $_kver = $1
    package { "${openafs::resource::client::kernel_module_package_prefix}${_kver}":
      ensure => $package_ensure,
    }
  }
}
