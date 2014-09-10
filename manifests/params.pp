#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::params
#
# This class is meant to be called from openafs
# It sets variables according to platform
#
class openafs::params {
  case $::osfamily {
    'Debian': {
      # nothing here
    }
    'RedHat', 'Amazon': {
      # nothing here
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
