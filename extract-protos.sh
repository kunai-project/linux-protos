#!/bin/bash

set -euo pipefail

ROOT=$(dirname $(realpath $0))

[ ! -d linux ] && git clone https://github.com/torvalds/linux.git

cd linux
git checkout master
git pull 

while read version
do
    out=$ROOT/protos/$version.txt
    if [ ! -f "$out.gz" ]
    then
        git checkout -f $version
        while read file
        do 
            echo "$version: $file"
            file=$(sed -e 's/^\.\///' <<<$file)
            $ROOT/cprotos.sh $file | sed -e"s#^#$version:$file:#" >> $out
        done < <(find -type f -name '*.c' )
        gzip $out
    fi
done < <(git tag | grep -E 'v(([5-9]|[0-9][0-9]+))\.[0-9]+$' | sort -V)