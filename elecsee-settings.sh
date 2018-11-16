#!/bin/bash
export elecsee_commands=$(dirname $0)/elecsee-commands
export LINUX="--dist=ubuntu --release=xenial --arch=amd64"
export RUNSOCKET=/tmp/elecsee-run-socket

[ ! "$debug" = "true" ] && [[ $- == *x* ]] && debug=true || debug=false
[ "${debug}" = "true" ] && logfile=/dev/stdout || logfile=/dev/null
export logfile debug

