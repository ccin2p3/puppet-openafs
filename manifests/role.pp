#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::role
# 
# This is the role base class which will be inherited by all "role" classes
# 
# Remember:
# Compose resources into "resource" classes
# Compose "resource" classes into "profile" classes
# Compose "profile" classes into "role" classes
#
class openafs::role {
  include openafs
  include ::openafs::profile::base
}
