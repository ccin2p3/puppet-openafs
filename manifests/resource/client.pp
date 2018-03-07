#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::client
#
# This class is called from openafs::profile::client
# it sets up the client part of openafs
#
class openafs::resource::client (
  Enum['present','absent'] $ensure,
  Variant[String[1], Array[String[1]]] $package_name,
  String[1] $service_name,
  Boolean $service_hasstatus,
  String $service_status,
  String $init_defaults,
  String[2] $this_cell_file,
  String[2] $cellservdb_file,
  String[2] $cell_alias_file,
  Hash $postinit,
) {
  include openafs

  class { 'openafs::resource::client::install':
    ensure  => $ensure
  } ->
  class { 'openafs::resource::client::config':
    ensure  => $ensure,
    postinit => $postinit,
  } ->
  class { 'openafs::resource::client::service':
    ensure  => $ensure
  } ->
  Class['openafs::resource::client']
}
