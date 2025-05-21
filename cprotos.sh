#!/bin/bash

awk '/^[a-zA-Z_][a-zA-Z0-9_ \t\*\(\),]*\(/ {  # match start of function signature
    prototype = $0;
    while (prototype !~ /\)/ && getline) {
        prototype = prototype $0;
    }

    gsub(/[[:space:]]+/, " ", prototype);
    print prototype;
}' $1
