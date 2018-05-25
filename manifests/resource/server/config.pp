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
  Array[String[1]] $admins = ['admin'],
  Array[Hash[String[1],String[1]]] $dbservers,
  Enum['present','absent'] $ensure,
  String[2] $dir,
)
{
  include ::openafs::resource::server
  case $ensure {
    present: {
      $dir_ensure = 'directory'
    }
    absent: {
      $dir_ensure = $ensure
    }
  }
  $cell_name = $::openafs::config::cell_name
  file { $dir:
    ensure  => $dir_ensure,
  }
  file { "${dir}/UserList":
    ensure  => $ensure,
    content => join($admins,"\n"),
    require => File[$dir],
  }
  file { "${dir}/ThisCell":
    ensure  => $ensure,
    content => "${cell_name}\n",
    require => File[$dir],
  }
  file { "${dir}/CellServDB":
    ensure => $ensure,
    owner  => '0',
    group  => '0',
    mode   => '0644',
    content => epp(
      'openafs/server/CellServDB.epp',
      {
        'dbservers' => $dbservers,
        'cell_name' => $cell_name,
      }
    ),
  }
}
