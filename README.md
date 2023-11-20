
# package

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
     * [Requirements](#requirements)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Limitations](#limitations)
7. [License](#license)
8. [Development](#development)

## Overview

This module provides the package task.

## Description

This task allows you to install, uninstall, update, and check the status of packages.

## Setup

### Requirements

This module is compatible with Puppet Enterprise and Puppet Bolt.

* To run tasks with Puppet Enterprise, PE 2018.1 or later must be installed on the machine from which you are running task commands. Machines receiving task requests must be Puppet agents.

* To run tasks with Puppet Bolt, Bolt 1.0 or later must be installed on the machine from which you are running task commands. Machines receiving task requests must have SSH or WinRM services enabled.

## Usage

To view the available actions and parameters, on the command line, run `puppet task show package` or see the package module page on the [Forge](https://forge.puppet.com/puppetlabs/package/tasks).
For a complete list of optional package providers that are supported, see the [Puppet Types](https://docs.puppet.com/puppet/latest/types/package.html) documentation.

To run a package task, use the task command, specifying the action and the name of the package.
To show help for the task CLI, run `puppet task run --help` or `bolt task run --help`

* With PE on the command line, run `puppet task run package action=<ACTION> name=<PACKAGE_NAME>`.
* With Bolt on the command line, run `bolt task run package action=<ACTION> name=<PACKAGE_NAME>`.

For example, to check whether the vim package is present or absent, run:

* With PE, run `puppet task run package action=status name=vim --nodes neptune`.
* With Bolt, run `bolt task run package action=status name=vim --nodes neptune --modulepath ~/modules`.

You can also run tasks in the PE console. See PE task documentation for complete information.

## Reference

For information on the classes and types, see the [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-package/blob/main/REFERENCE.md).

## Limitations

For an extensive list of supported operating systems, see [metadata.json](https://github.com/puppetlabs/puppetlabs-package/blob/main/metadata.json)

## License

This codebase is licensed under the Apache2.0 licensing, however due to the nature of the codebase the open source dependencies may also use a combination of [AGPL](https://www.gnu.org/licenses/agpl-3.0.en.html), [BSD-2](https://opensource.org/license/bsd-2-claus), [BSD-3](https://opensource.org/license/bsd-3-claus), [GPL2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html), [LGPL](https://opensource.org/license/lgpl-3-0/), [MIT](https://opensource.org/license/mit/) and [MPL](https://opensource.org/license/mpl-2-0/) Licensing.

## Development

Tests are ran using [puppet_litmus](https://github.com/puppetlabs/puppet_litmus). To run the acceptance tests follow the instructions from this point [here](https://github.com/puppetlabs/puppet_litmus/wiki/Tutorial:-use-Litmus-to-execute-acceptance-tests-with-a-sample-module-(MoTD)#install-the-necessary-gems-for-the-module).

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. To contribute to Puppet projects, see our [module contribution guide.](https://github.com/puppetlabs/puppetlabs-package/blob/main/CONTRIBUTING.md)

