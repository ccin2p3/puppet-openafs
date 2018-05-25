#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::server
#
# This class is called from openafs::profile::server
# it sets up the server part of openafs
#
class openafs::resource::server (
  Enum['present','absent'] $ensure,
  Variant[String[1], Array[String[1]]] $package_name,
  Boolean $service_hasstatus,
  String[1] $service_name,
) {
  include openafs

  class { 'openafs::resource::server::install':
    ensure  => $ensure
  } ->
  class { 'openafs::resource::server::config':
    ensure  => $ensure,
  } ~>
  class { 'openafs::resource::server::service':
    ensure  => $ensure
  } ->
  Class['openafs::resource::server']
}
