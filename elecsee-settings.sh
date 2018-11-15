#!/bin/bash
if [ "$EUID" = "0" ]
  then echo "Run as user, not root, sudo will be used where appropriate"
  exit 1
fi
export elecsee_commands=$(dirname $0)/elecsee-commands
export LINUX="--dist=ubuntu --release=xenial --arch=amd64"
export RUNSOCKET=/tmp/elecsee-run-socket

[ ! "$debug" = "true" ] && [[ $- == *x* ]] && debug=true || debug=false
[ "${debug}" = "true" ] && logfile=/dev/stdout || logfile=/dev/null
export logfile debug

declare -A _ARGSPEC=(
    # only 3 letter subcommands - onn :-)
    [run]="" # run is a server used for sequencing names, exposures etc.
    [nur]="CMD[]" # nur is the client communicating with run
    [onn]="CONTAINER" # lxc-start etc.
    [off]="CONTAINER" # lxc stop etc.
    [del]="CONTAINER" # lxc-destroy etc.
    [new]="CONTAINER" # lxc-create / lxc-copy
    [net]="CONTAINER" # ping until network is up
    [cmd]="CONTAINER CMD[]" # lxc-attach 
    [lst]="" # lxc-ls --fancy -Fname,ipv4
    [xfr]="CONTAINER SOURCE DESTINATION" # file into container (using lxc-attach)
    [rcv]="CONTAINER SOURCE DESTINATION" # file from container (using lxc-attach)
)
export _ARGSPEC

declare -A _NURSPEC=(
    # only 4 letter subcommands 
    [expo]="CONTAINER INTERNAL EXTERNAL" # expose internal on external using socat
    [opxe]="CONTAINER EXTERNAL[]" # remove container exposures from externals
    [name]="CONTAINER IP[]" # set container to ipadrs in /etc/hosts
    [eman]="CONTAINER" # remove container from /etc/hosts
    [auto]="CONTAINER" # set container to start automatically using systemctl
    [otua]="CONTAINER" # remove container from autostart
)
export _NURSPEC

declare -A _ERRSPEC=(
    # error explanations
    [0]=''
    [1]='too few arguments'
    [2]='excess arguments'
    [3]='too few arguments'
)
export _ERRSPEC
