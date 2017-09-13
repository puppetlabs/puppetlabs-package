
# package_task

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with package task](#setup)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module provides the package task. This task allows you to install, uninstall, update, and check the status of packages.

This module requires either Puppet Enteprise 2017.3 or the `bolt` task runner. [TODO: as I understand it, this module does not currently work with bolt and depends on Puppet 5 to be installed. We will modify this text when that is resolved.]

## Setup

[TODO: is there any setup beyond "install the module"?]

### Requirements

This module requires either the `bolt` task runner or Puppet Enteprise 2017.3 or later to be installed on the machine from which you are running task commands (the controller node).

## Usage

To run a package task, use the task command, specifying the action and the name of the package.

### Puppet Enterprise

With Puppet Enterprise, on the command line, run `puppet task package <ACTION> <PACKAGE_NAME>.

For example, to check whether the vim package is present or absent, run `puppet task package status vim`

You can also run tasks in the PE console. See [Running tasks in PE](TODO: LINK) for complete information.

### Puppet task runner

With the standalone task runner `bolt`, run `bolt task package <ACTION> <PACKAGE_NAME>.

For example, to check whether the vim package is present or absent, run `bolt task package status vim`

For detailed task runner information, see the [`bolt` task runner documentation](TODO LINK).

## Reference

### Parameters

[TODO: I might change these to a table instead]

#### action

**Required**.

The operation (install, status, uninstall and upgrade) to perform on the package.

Data type: "Enum[install, status, uninstall, upgrade]

#### package

**Required**.

The name of the package to be manipulated.

Data type: String[1]

#### version

**Optional**.

Version numbers must match the full version to install, including release if the provider uses a release moniker. Ranges or semver patterns are not accepted except for the gem package provider.

For example, to install the bash package from the `rpm bash-4.1.2-29.el6.x86_64.rpm`, use the string '4.1.2-29.el6'."

Data type: Optional[String[1]]

#### provider

**Optional**.

The provider to use to manage or inspect the package.

Data type: Optional[String[1]]

Defaults to the system package manager.

For a complete list of optional package providers that are supported, see the [Puppet Types](https://docs.puppet.com/puppet/latest/types/package.html) documentation.

## Development 

[TODO: this section is for internal Puppet users and will be deleted before module release.]

Here is a quick how to get up and running 

1. Clone the package repo:

```
git clone git@github.com:puppetlabs/package.git
```

2. Install the gem dependencies:

```
bundle install --path .bundle/gems/
```

3. Get a VMPooler machine from Beaker.

```
BEAKER_destroy=no PUPPET_INSTALL_TYPE=pe BEAKER_PE_DIR=http://enterprise.delivery.puppetlabs.net/2017.3/ci-ready  BEAKER_PE_VER=2017.3.0-rc8-41-g4981bd3 BEAKER_set=centos7-pooler  bundle exec rspec spec/acceptance
```

4. SSH to the VMPooler machine output by the previous command.

```
ssh -i ~/.ssh/id_rsa-acceptance root@<VMPOOLER HOSTNAME FROM ABOVE> 
```

5. Show the status of the `openssl` package, specifying the node you want to check.

```
puppet task run package --nodes cgx1boldbmbi3vn.delivery.puppetlabs.net action=status package=openssl
```

## Getting help

To display help for the package task, run:

```
puppet task show package
```

To show help for the task CLI, run: [TODO: is this for bolt or for some tasks code in Puppet itself? If in Puppet itself, will this only work on PE?]

```
puppet task run --help
```
