#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with openafs](#setup)
    * [What openafs affects](#what-openafs-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with openafs](#beginning-with-openafs)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages [OpenAFS](http://www.openafs.org/).

## Module Description

This module handles installation and configuration of OpenAFS clients.
In the future it will also manage server instances

## Setup

### What openafs affects

Most affected resources are os-dependant. Here's the list of logically affected resources:

* Package installation
* File `ThisCell`
* Init script defaults file

### Setup Requirements

* augeas
* stdlib
* supported and tested with `Debian` and `RedHat` osfamilies
* on `RedHat` chances are you'll need *EPEL* enabled repository

### Beginning with openafs

This module implemets the role/profile/resource layered [model](http://puppetlabs.com/presentations/designing-puppet-rolesprofiles-pattern). Roles and Profiles take no parameters.

## Usage

### Client

```puppet
include openafs::role::client
```

Setting `AFS_POST_INIT` will add the contents to the startup file. This can be used for instance to set the `sysname`:

```puppet
class {'openafs::resource::client::config':
  postinit => {
  	path => '/path/to/postinit-script',
  	content => "fs sysname ${::architecture}_${short_operatingsystem}${::operatingsystemmajrelease}"
  }
}
class {'openafs::role::client':}
```

You can also override the shipped `CellServDB` file:

```puppet
class {'openafs::resource::client::config':
  cellservdb_content => epp('mymodule/CellServDB.epp')
}
```


## Reference

### Class openafs

### Class openafs::config

* `cell_name` defaults to `$::domain`

### Class openafs::role::client

### Class openafs::profile::client

### Class openafs::resource::client

### Class openafs::resource::client::config

* `sysname` string to override sysname

## Limitations

* No server role yet

## Development

https://github.com/ccin2p3/puppet-openafs
https://github.com/ccin2p3/puppet-openafs/issues

