#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::role::client
# 
# This is the "client" role which will set up everything for a node
# to be able to read and write to openafs
#
class openafs::role::client {
  include '::openafs::role'
  include '::openafs::profile::client'
}
