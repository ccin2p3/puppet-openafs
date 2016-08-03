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
  $ensure = present,
) inherits openafs::params {

  # validate parameters here

  class { 'openafs::install': }
  include ::openafs::config
  class { 'openafs::service': }

  Class['openafs::install'] ->
  Class['openafs::config'] ~>
  Class['openafs::service'] ->
  Class['openafs']
}
