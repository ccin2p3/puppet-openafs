#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::server
#
# This class is called from openafs::resource::server
# It manages how the resource 'server' is configured
#
class openafs::resource::server::config (
  Array[String[1]] $admins = ['admin']
)
{
  $cell_name = $::openafs::config::cell_name
  file { $::openafs::resource::server::config_dir:
    ensure  => directory,
  }
  file { "${::openafs::resource::server::config_dir}/UserList":
    ensure  => present,
    content => inline_template('<% admins.each do |a| puts a end %>'),
    require => $::openafs::resource::server::config_dir,
  }
  file { "${::openafs::resource::server::config_dir}/ThisCell":
    ensure  => present,
    content => $cell_name,
    require => $::openafs::resource::server::config_dir,
  }
  openafs::resource::cellservdb { "${::openafs::resource::server::config_dir}/CellServDB": }
  Openafs::Resource::Cellservdb::Fragment <<| cell_name == $cell_name |>> {
    target => "${::openafs::resource::server::config_dir}/CellServDB"
  }
}
