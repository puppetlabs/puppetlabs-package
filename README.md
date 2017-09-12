
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

This module provides the package task. This task allows you to execute various actions against packages, such as installing or [TODO: ??? Does it just install? What else can you do with it?

For example, you can use the package task to install vim with the apt package provider. Tasks require either Puppet Enteprise 2017.3 or the `bolt` task runner.

## Setup

### Setup requirements

This module requires either Puppet Enteprise 2017.3 or the `bolt` task runner.

## Usage

There are a number of ways to execute the package task. [TODO: what ways?]

The examples below check the status of the vim package. [TODO: when you say "status," you just mean present or absent, yes?]

On the PE console, TODO: DO A THING [TODO: LINK]

With PE on the command line TODO: MORE INFO HERE EEP TODO: LINK

```bash
puppet task package status vim
```

With the standalone `bolt` task runner [TODO: LINK], on the command line [TODO: Do they need to be in a certain directory for this, like a tasks dir or anything?], run:

```bash
bolt task package status vim
```

## Reference

[TODO: we actually need to list these here]

To get the available actions and parameters, run:

``` bash
puppet task show package
```

or go to https://forge.puppet.com/puppetlabs/package/tasks [TODO: Jean to remove this, as it basically points to itself on the Forge. I want it for reference now though.]

For a complete list of optional package providers that are supported, see the [Puppet Types](https://docs.puppet.com/puppet/latest/types/package.html) documentation.

## Development

Here is a quick how to get up and running 

1. Clone the package repo:

```
git clone git@github.com:puppetlabs/package.git
```

2. Install the gem dependencies:

```
bundle install --path .bundle/gems/
```

3. Do some Beaker stuff [TODO: if this is going to be public-facing, we need to describe whatever is going on here briefly; if this bit is internal to us only, then it's fine.]

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

## Help

To display help for the package task, run:

```
puppet task show package
```

To show help for the task CLI, run: [TODO: is this for bolt or for some tasks code in Puppet itself? If in Puppet itself, will this only work on PE?]

```
puppet task run --help
```
