#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::client::service
#
# This class is meant to be called from openafs::resource::client
# It ensures the service is running
#
class openafs::resource::client::service (
  $ensure = $::openafs::ensure
)
{
  case $ensure {
    present: {
      $service_ensure = running
      $service_enable = true
    }
    absent: {
      $service_ensure = stopped
      $service_enable = false
    }
    default: {
      fail("Unsupported ensure value `${ensure}`")
    }
  }
  service { $openafs::resource::client::params::service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => $openafs::resource::client::params::service_hasstatus,
    status     => $openafs::resource::client::params::service_status,
    hasrestart => true,
  }
}
