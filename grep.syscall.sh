#!/bin/bash

PATTERN=$1
shift
if which rg > /dev/null
then 
    rg -z ":SYSCALL_DEFINE[0-9]\($PATTERN," $@
else
    zgrep -E ":SYSCALL_DEFINE[0-9]\($PATTERN," $@
fi