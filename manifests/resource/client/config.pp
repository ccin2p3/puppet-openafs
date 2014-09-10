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
  $sysname = false
)
{
  # force sysname to user specified value
  if $sysname {
    augeas { 'setup sysname in post_init':
      incl    => $::openafs::resource::client::params::init_defaults,
      lens    => 'Shellvars.lns',
      changes => "set AFS_POST_INIT \"'fs sysname ${sysname}'\""
    }
  }
  file { $::openafs::resource::client::params::this_cell_file:
    ensure  => present,
    content => "${::openafs::config::cell_name}\n"
  }
  
}
