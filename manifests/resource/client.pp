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
  $package_name = $openafs::resource::client::params::package_name,
  $service_name = $openafs::resource::client::params::service_name,
) inherits openafs::resource::client::params {

  # validate parameters here

  class { 'openafs::resource::client::install': } ->
  class { 'openafs::resource::client::config': } ~>
  class { 'openafs::resource::client::service': } ->
  Class['openafs::resource::client']
}
