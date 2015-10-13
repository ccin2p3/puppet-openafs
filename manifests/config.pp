#
# Copyright (c) IN2P3 Computing Centre, IN2P3, CNRS
#
# Contributor(s) : ccin2p3
#

# == Class openafs::config
#
# This class is called from openafs
#
class openafs::config (
  $cell_name = $::domain,
  $cell_alias = {}
)
{
  validate_string($cell_name)
  validate_hash($cell_alias)
}
