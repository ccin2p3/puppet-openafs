#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::server::service
#
# This class is meant to be called from openafs::resource::server
# It ensures the service is running
#
class openafs::resource::server::service (
  Enum['present','absent'] $ensure = $::openafs::ensure,
)
{
  include ::openafs::resource::server
  case $ensure {
    present: {
      $service_ensure = running
      $service_enable = true
      $unload_module = false
    }
    absent: {
      $service_ensure = stopped
      $service_enable = false
      $unload_module = true
    }
    default: {
      fail("Unsupported ensure value `${ensure}`")
    }
  }
  service { $openafs::resource::server::service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => $openafs::resource::server::service_hasstatus,
    status     => $openafs::resource::server::service_status,
    hasrestart => true,
  }
  if $unload_module and str2bool($::kmod_isloaded_openafs) {
    exec { 'openafs_resource_server_unload_module':
      path    => '/sbin',
      command => 'rmmod openafs'
    }
  }
}
