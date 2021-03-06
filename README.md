# puppet

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module is intended to manage puppet by itself. Main use case is to manage puppet agents, but also puppet servers are meant to be managed by puppet itself.

This module was written for Puppet 4.0.0. Not sure if also working with versions <4.0.0.

Supported OSes are RHEL based systems. This module was tested on
* CentOS 6.6
* CentOS 5.11

## Module Description


## Setup

### What puppet affects

* includes sixt-cron module to ensure cron is up and running.

### Setup Requirements

no special requirements, except the standard requirements for puppet.

### Beginning with puppet

The very basic steps needed for a user to get the module up and running.

> include puppet


## Usage

## Limitations

Tested with CentOS 6.6 and 5.11.

No implementation for other systems than RHEL based done or planned.


## Release Notes/Contributors/Etc



