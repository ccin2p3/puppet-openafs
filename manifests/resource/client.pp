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
  $ensure,
  $package_name,
  $service_name,
  $service_hasstatus,
  $service_status,
  $init_defaults,
  $this_cell_file,
  $cellservdb_file,
  $cell_alias_file,
  $postinit,
) {
  include openafs

  # validate parameters here
  validate_hash($postinit)

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
