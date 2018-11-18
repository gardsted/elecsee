ELECSEE

This is the documentation of elecsee, a utility for easing my use of lxc on ubuntu.

It can do three things that I missed:
    1) put containers in /etc/hosts automatically
    2) make containers autostartable using systemd units
    3) expose TCP and UDP services from containers on the primary interface of the host

elecsee has a set of subcommands that takes parameters, but no flags - below is a summary

pxe
    elecsee pxe takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER

lst
    elecsee lst takes no arguments

off
    elecsee off takes the following arguments: CONTAINERS[]

net
    elecsee net takes the following arguments: CONTAINERS[]

tua
    elecsee tua takes the following arguments: CONTAINERS[]

new
    elecsee new takes the following arguments: CONTAINERS[]

aut
    elecsee aut takes the following arguments: CONTAINERS[]

del
    elecsee del takes the following arguments: CONTAINERS[]

onn
    elecsee onn takes the following arguments: CONTAINERS[]

hlp
    elecsee hlp takes no arguments

doc
    elecsee doc takes no arguments
hst
    elecsee hst takes no arguments

exp
    elecsee exp takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER

in the script directory and have to functions which are called from this script
        'model' is called if a model does not exist
        'instance' is called last and creates a container of the specified name

        a container called solr-1 wil have a model called solr-model, hence model is a forbidden container suffix in elecsee
    aut will put CONTAINER into autostart using a systemd unit file named after the container: elecsee-CONTAINER-service
    tua will reverse that action, disabling and stopping the service
    del will delete  CONTAINERS - even if they are running (using the --force flag on lxc-destroy)
    onn starts all containers on the command line

    exp exposes an UDP or TCP service from the container on the hosts interfaces using socat port forwarding
    pxe reverses the action, removing the exposure
