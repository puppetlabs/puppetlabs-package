
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

To view the available actions and parameters, on the command line, run `puppet task show package` or see the package module page on the [Forge](https://forge.puppet.com/puppetlabs/package/tasks).

For a complete list of optional package providers that are supported, see the [Puppet Types](https://docs.puppet.com/puppet/latest/types/package.html) documentation.

## Getting help

To display help for the package task, run:

```
puppet task show package
```

To show help for the task CLI, run: [TODO: is this for bolt or for some tasks code in Puppet itself? If in Puppet itself, will this only work on PE?]

```
puppet task run --help
```
