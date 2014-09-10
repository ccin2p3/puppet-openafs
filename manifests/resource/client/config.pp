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
  $sysname = false,
  $ensure = $::openafs::ensure
)
{
  # force sysname to user specified value
  case $ensure {
    present: {
      if $sysname {
        augeas { 'setup sysname in post_init':
          incl    => $::openafs::resource::client::params::init_defaults,
          lens    => 'Shellvars.lns',
          changes => "set AFS_POST_INIT \"'fs sysname ${sysname}'\""
        }
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
    content => "${::openafs::config::cell_name}\n"
  }
  
}
