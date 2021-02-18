# ma_setup

`ma_setup` is a simple bolt project which automates the process of provisioning and configuring a puppetserver and N puppet agents.
This script uses the power of bolt plans to prepare a master-agent configuration.
To run this script it is required to have `bolt` installed([here](https://puppet.com/docs/bolt/latest/bolt_installing.md) is all about bolt installation)

## Installation

The installation requires two steps to be done:

1. clone this repo

```shell
git clone https://github.com/adrianiurca/ma_setup.git
```

2. install project dependencies

```shell
cd ma_setup
bolt module install
```

... and now you can start using `ma_setup`

## Available plans

### ma_setup::provision_machines

This plan provision all machines that you need using different provisioners(such as docker, vagrant or custom provisioners)

```shell
bolt plan run ma_setup::provision_machines provisioner="vagrant" master="centos/7" agent_oses='["ubuntu/xenial64","ubuntu/bionic64"]'
```

### ma_setup::server

This plan install and configure puppetserver on master server

```shell
bolt plan run ma_setup::server
```

### ma_setup::agents

This plan install and configure puppet-agent on all agents

```shell
bolt plan run ma_setup::agents collection="puppet6"
```

## Getting Help

- [#bolt on Slack](https://slack.puppet.com/) - Join the Bolt developers and community
