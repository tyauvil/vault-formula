
[![Vault](./assets/vault_logo.png "Docker")](https://www.vaultproject.io)
vault-formula
==============

[Vault](https://www.vaultproject.io) is a secret managment tool allowing applications and users to gain access to sensitive mission critical infromation. This allows us to remove secrets from unsecure locations and manage them in a central location. 

Available states
================

``vault``
----------

Installs Vault server binary and creats an upstart service to ensure vault is running.

Configuration Options
=====================

`statsd_address` - Where to tell consul to send statistics about the running process.
`consul_address` - Tells vault where to find the consul backend for a highly avaliable deployment. If not specified, it falls back to the file backend to store secrets encrypted on disk. 
