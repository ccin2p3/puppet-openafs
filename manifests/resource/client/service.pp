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
class openafs::resource::client::service {

  service { $openafs::resource::client::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
