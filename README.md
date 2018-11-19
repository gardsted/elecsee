# ELECSEE

This is the documentation of elecsee, a utility for easing my use of lxc on ubuntu.

It can do three things that I missed:

* put containers in /etc/hosts automatically
* make containers autostartable using systemd units
* expose TCP and UDP services from containers on the primary interface of the host

This is not a docker replacement. Lots can go wrong when building the containers, using bash -x $(which elecsee) should turn on full debugging

Elecsee has a set of subcommands that takes parameters, but no flags - below is a summary

## pxe

**elecsee pxe** takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER

exp exposes an UDP or TCP service from the container on the hosts interfaces using socat port forwarding
pxe reverses the action, removing the exposure

running this command:

    sudo elecsee exp TCP 8983 80 solr-1

will produce the file **/etc/systemd/system/elecsee-exp-TCP-solr-1-8983-80.service** with the following contents and enable and start it

    [Unit]
    Description=elecsee expose TCP on solr-1:8983 on external 80

    [Service]
    Type=simple
    ExecStart=/usr/bin/socat TCP-LISTEN:80,fork,reuseaddr TCP:solr-1:8983

    [Install]
    WantedBy=multi-user.target

while running this command:

    sudo elecsee pxe TCP 8983 80 solr-1

will stop and disable the service and subsequently remove the file

forwarding is as You see currently done using only socat, but it probably should be extended to using both this (for accesing from host it self) and maybe iptables (for accessing from outside) there is an entry on superusers [here](https://superuser.com/questions/1322143/prerouting-to-lxc-container-with-iptables)
furthermore there is one here, that is way more interesting - on [containerops](http://containerops.org/2013/11/19/lxc-networking/) dissussing all kinds of container/networking related  It seems that it is possible to let the container access the physical interface. I wonder what happens when I go on vpn?


## lst

**elecsee lst** takes no arguments

lst lists hosts+ips using lxc-ls --fancy without headers 

The follwing example shows calling elecsee lst and it's output

    sudo elecsee lst
    solr-1      10.0.3.19 
    solr-model  -         

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

running the command:

    sudo elecsee aut solr-1

will create a file: **/etc/systemd/system/elecsee-solr-1.service** with the following contents, enabling and starting it:

    [Unit]
    Description=elecsee run solr-1

    [Service]
    Type=forking
    ExecStart=/usr/bin/elecsee/elecsee onn solr-1
    ExecStop=/usr/bin/elecsee/elecsee off solr-1

    [Install]
    WantedBy=multi-user.target

This can be seen using:

    sudo systemctl status elecsee-solr-1.service

Which will give an output similar to this

    ● elecsee-solr-1.service - elecsee run solr-1
       Loaded: loaded (/etc/systemd/system/elecsee-solr-1.service; enabled; vendor preset: enabled)
       Active: active (running) since Mon 2018-11-19 20:48:27 CET; 5min ago
      Process: 14105 ExecStart=/usr/bin/elecsee/elecsee onn solr-1 (code=exited, status=0/SUCCESS)
     Main PID: 14120 (lxc-start)
        Tasks: 1 (limit: 4915)
       CGroup: /system.slice/elecsee-solr-1.service
               └─14120 [lxc monitor] /var/lib/lxc solr-1



## new

**elecsee new** takes the following arguments: CONTAINERS[]

new creates container from a model, and if the model does not exist, it creates the model first 
models are placed in the script directory and have to functions which are called from this script
'model' is called if a model does not exist
'instance' is called last and creates a container of the specified name

The following example shows the creation of a solr node

    sudo ./elecsee new solr-1
    building model
    add ssh, users (clint and donald) and public certificates to model
    add java 8 to model - this will take some time
    add solr-7.5.0 to model - this will take some time
    building solr-1


## aut

**elecsee aut** takes the following arguments: CONTAINERS[]

aut will put CONTAINER into autostart using a systemd unit file named after the container: elecsee-CONTAINER-service
tua will reverse that action, disabling and stopping the service

running the command:

    sudo elecsee aut solr-1

will create a file: **/etc/systemd/system/elecsee-solr-1.service** with the following contents, enabling and starting it:

    [Unit]
    Description=elecsee run solr-1

    [Service]
    Type=forking
    ExecStart=/usr/bin/elecsee/elecsee onn solr-1
    ExecStop=/usr/bin/elecsee/elecsee off solr-1

    [Install]
    WantedBy=multi-user.target

This can be seen using:

    sudo systemctl status elecsee-solr-1.service

Which will give an output similar to this

    ● elecsee-solr-1.service - elecsee run solr-1
       Loaded: loaded (/etc/systemd/system/elecsee-solr-1.service; enabled; vendor preset: enabled)
       Active: active (running) since Mon 2018-11-19 20:48:27 CET; 5min ago
      Process: 14105 ExecStart=/usr/bin/elecsee/elecsee onn solr-1 (code=exited, status=0/SUCCESS)
     Main PID: 14120 (lxc-start)
        Tasks: 1 (limit: 4915)
       CGroup: /system.slice/elecsee-solr-1.service
               └─14120 [lxc monitor] /var/lib/lxc solr-1



## del

**elecsee del** takes the following arguments: CONTAINERS[]

del will delete  CONTAINERS - even if they are running (using the --force flag on lxc-destroy)

## onn

**elecsee onn** takes the following arguments: CONTAINERS[]

onn starts all containers on the command line

## hlp

**elecsee hlp** takes no arguments

The following example will print out the help text

    elecsee hlp

## doc

**elecsee doc** takes no arguments


## hst

**elecsee hst** takes no arguments



## exp

**elecsee exp** takes the following arguments: PROTO INTERNAL EXTERNAL CONTAINER

exp exposes an UDP or TCP service from the container on the hosts interfaces using socat port forwarding
pxe reverses the action, removing the exposure

running this command:

    sudo elecsee exp TCP 8983 80 solr-1

will produce the file **/etc/systemd/system/elecsee-exp-TCP-solr-1-8983-80.service** with the following contents and enable and start it

    [Unit]
    Description=elecsee expose TCP on solr-1:8983 on external 80

    [Service]
    Type=simple
    ExecStart=/usr/bin/socat TCP-LISTEN:80,fork,reuseaddr TCP:solr-1:8983

    [Install]
    WantedBy=multi-user.target

while running this command:

    sudo elecsee pxe TCP 8983 80 solr-1

will stop and disable the service and subsequently remove the file

forwarding is as You see currently done using only socat, but it probably should be extended to using both this (for accesing from host it self) and maybe iptables (for accessing from outside) there is an entry on superusers [here](https://superuser.com/questions/1322143/prerouting-to-lxc-container-with-iptables)
furthermore there is one here, that is way more interesting - on [containerops](http://containerops.org/2013/11/19/lxc-networking/) dissussing all kinds of container/networking related  It seems that it is possible to let the container access the physical interface. I wonder what happens when I go on vpn?

