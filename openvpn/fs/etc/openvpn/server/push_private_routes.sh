#!/bin/bash

SWD=$(dirname $0)

# Import our environment variables from systemd
for e in $(tr "\000" "\n" < /proc/1/environ); do
    eval "export $e"
done



