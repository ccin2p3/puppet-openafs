#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class: openafs
#
# Full description of class openafs here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class openafs (
  Enum['present', 'absent'] $ensure,
) {

  include ::openafs::config

  Class['openafs::config'] ~>
  Class['openafs']
}
