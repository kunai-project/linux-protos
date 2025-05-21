#!/bin/bash
PATTERN=$1
shift
if which rg > /dev/null
then 
    # we use ripgrep if available
    rg -z "\s$PATTERN\(" $@ | cut -d ':' -f 2- | sort -V
else
    zgrep -E "\s$PATTERN\(" $@ | cut -d ':' -f 2- | sort -V
fi