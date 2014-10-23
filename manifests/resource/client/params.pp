#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::resource::client::params
#
# This class is meant to be called from openafs::resource::client::config
# It sets variables according to platform
#
class openafs::resource::client::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'openafs-client'
      $service_name = 'openafs-client'
      $service_hasstatus = true
      $config_file = '/etc/openafs.conf'
      $config_include_dir = '/etc/openafs/conf.d'
      $init_defaults = '/etc/openafs/afs.conf'
      $this_cell_file = '/etc/openafs/ThisCell'
    }
    'RedHat', 'Amazon': {
      case $::operatingsystem {
        'RedHat': {
          $package_name = ['openafs-client','openafs-compat','pam_afs_session', 'dkms-openafs']
        }
        default: {
          $package_name = ['openafs-client','openafs-compat','pam_afs_session', 'kmod-openafs']
        }
      }
      $service_name = 'afs'
      $service_hasstatus = false
      $service_status = 'pgrep -x afsd'
      $config_file = '/etc/openafs.conf'
      $config_include_dir = '/etc/openafs/conf.d'
      $init_defaults = '/etc/sysconfig/afs'
      $this_cell_file = '/usr/vice/etc/ThisCell'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

