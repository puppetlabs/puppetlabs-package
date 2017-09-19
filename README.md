
# package

#### Table of Contents

1. [Description](#description)
2. [Requirements](#requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Getting help - Some Helpful commands](#getting-help)

## Description

This module provides the package task. This task allows you to install, uninstall, update, and check the status of packages.

## Requirements

This module requires Puppet Enterprise 2017.3 or later to be installed on the machine from which you are running task commands (the controller node). Machines receiving task requests must be Puppet agents.

## Usage

To run a package task, use the task command, specifying the action and the name of the package.

1. On the command line, run `puppet task package <ACTION> <PACKAGE_NAME>`.

For example, to check whether the vim package is present or absent, run `puppet task package status vim`

You can also run tasks in the PE console. See PE task documentation for complete information.

## Reference

To view the available actions and parameters, on the command line, run `puppet task show package` or see the package module page on the [Forge](https://forge.puppet.com/puppetlabs/package/tasks).

For a complete list of optional package providers that are supported, see the [Puppet Types](https://docs.puppet.com/puppet/latest/types/package.html) documentation.

## Getting Help

To display help for the package task, run `puppet task show package`

To show help for the task CLI, run `puppet task run --help`

