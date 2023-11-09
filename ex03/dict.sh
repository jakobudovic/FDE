#!/bin/bash
#!/usr/bin/env bash

set() {
  echo "$1,$2" >> database
}

get() {
  grep "^$1," database | tail -n 1 | sed -E -e "s/^$1,//" # substitute $1 and , to nothing
}

$1 "$2" "$3"

# time (for i in seq 1 1000; do echo $i; done;)
# to make it executable
# time (for i in $(seq 1 1000); do echo $i; done;)
