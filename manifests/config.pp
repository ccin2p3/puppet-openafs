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
  String[1] $cell_name = $::domain,
  Hash[String,String] $cell_alias = {}
)
{
  # I wonder if this class is still needed ◔̯◔
}
