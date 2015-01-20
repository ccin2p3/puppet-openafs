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
  $package_name = $openafs::params::package_name,
  $service_name = $openafs::params::service_name,
) inherits openafs::params {

  # validate parameters here

  include '::openafs::config'
  class { 'openafs::install': } ->
  Class ['openafs::config'] ~>
  class { 'openafs::service': } ->
  Class['openafs']
}
