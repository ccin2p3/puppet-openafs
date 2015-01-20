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
  $postinit = {},
  $ensure = $::openafs::ensure
)
{
  validate_hash($postinit)
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
      file { $::openafs::resource::client::params::init_defaults:
        ensure  => $ensure,
        content => template('openafs/client/sysconfig.afs.erb'),
      }
    }
    absent: {
      file { $::openafs::resource::client::params::init_defaults:
        ensure => $ensure
      }
    }
    default: {
      fail("ensure `${ensure}` is not supported")
    }
  }
  file { $::openafs::resource::client::params::this_cell_file:
    ensure  => $ensure,
    content => "${cell_name}\n"
  }
  
}
