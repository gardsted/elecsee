# ELECSEE

This is the documentation of elecsee, a utility for easing my use of lxc on ubuntu.

It can do three things that I missed:

* put containers in /etc/hosts automatically
* make containers autostartable using systemd units
* expose TCP and UDP services from containers on the primary interface of the host

elecsee has a set of subcommands that takes parameters, but no flags - below is a summary

## pxe

**elecsee pxe** takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER


exp exposes an UDP or TCP service from the container on the hosts interfaces using socat port forwarding

pxe reverses the action, removing the exposure

## lst

**elecsee lst** takes no arguments


lst lists hosts+ips using lxc-ls --fancy without headers 

## off

**elecsee off** takes the following arguments: CONTAINERS[]


off stops all containers on the command line

## net

**elecsee net** takes the following arguments: CONTAINERS[]


net awaits until all containers on the command line has network connection (this usually takes app. 4 seconds

## tua

**elecsee tua** takes the following arguments: CONTAINERS[]


aut will put CONTAINER into autostart using a systemd unit file named after the container: elecsee-CONTAINER-service

tua will reverse that action, disabling and stopping the service

## new

**elecsee new** takes the following arguments: CONTAINERS[]


new creates conteiner from a model, and if the model does not exist, it creates the model first 

models are placed in the script directory and have to functions which are called from this script

'model' is called if a model does not exist

'instance' is called last and creates a container of the specified name



a container called solr-1 wil have a model called solr-model, hence model is a forbidden container suffix in elecsee

## aut

**elecsee aut** takes the following arguments: CONTAINERS[]


aut will put CONTAINER into autostart using a systemd unit file named after the container: elecsee-CONTAINER-service

tua will reverse that action, disabling and stopping the service

## del

**elecsee del** takes the following arguments: CONTAINERS[]


del will delete  CONTAINERS - even if they are running (using the --force flag on lxc-destroy)

## onn

**elecsee onn** takes the following arguments: CONTAINERS[]


onn starts all containers on the command line

## hlp

**elecsee hlp** takes no arguments


## doc

**elecsee doc** takes no arguments


## hst

**elecsee hst** takes no arguments




## exp

**elecsee exp** takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER


exp exposes an UDP or TCP service from the container on the hosts interfaces using socat port forwarding

pxe reverses the action, removing the exposure
