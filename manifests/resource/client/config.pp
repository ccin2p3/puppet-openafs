#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::client
#
# This class is called from openafs::resource::client
# It manages how the resource 'client' is configured
#
class openafs::resource::client::config (
  Hash $postinit = {},
  Enum['present', 'absent'] $ensure = $::openafs::ensure,
  Variant[String,Undef] $cellservdb_content = undef,
)
{
  include ::openafs::resource::client
  if ! empty($postinit) {
    if has_key($postinit, 'path') {
      file{ $postinit['path']:
        ensure  => present,
        content => $postinit['content'],
        source  => $postinit['source'],
        notify  => Service[$::openafs::resource::client::service_name],
        mode    => '0755',
      }
    } else {
      fail('postinit must contain at least key "path"')
    }
  }
  $cell_name = $::openafs::config::cell_name
  case $ensure {
    present: {
      file { $::openafs::resource::client::init_defaults:
        ensure  => $ensure,
        content => template('openafs/client/sysconfig.afs.erb'),
      }
    }
    absent: {
      file { $::openafs::resource::client::init_defaults:
        ensure => $ensure
      }
    }
    default: {
      fail("ensure `${ensure}` is not supported")
    }
  }
  file { $::openafs::resource::client::this_cell_file:
    ensure  => $ensure,
    content => "${cell_name}\n"
  }
  unless empty ($::openafs::config::cell_alias) {
    $cellalias = $::openafs::config::cell_alias
    file { $::openafs::resource::client::cell_alias_file:
      ensure  => present,
      content => template('openafs/CellAlias.erb'),
    }
  }
  if $cellservdb_content =~ Undef {
    $_cellservdb_content = {
      source => 'puppet:///modules/openafs/client/CellServDB',
    }
  } else {
    $_cellservdb_content = {
      content => $cellservdb_content
    }
  }
  file { $::openafs::resource::client::cellservdb_file:
    ensure    => $ensure,
    owner     => '0',
    group     => '0',
    mode      => '0644',
    show_diff => false,
    *         => $_cellservdb_content,
  }
}
