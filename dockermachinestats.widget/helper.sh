#! /bin/bash

export PATH=$PATH:/usr/local/bin

getStatus() {
  docker-machine ls | grep -E 'Running|Stopped' | awk '{print $1, $5, $4}'
}

"$@"
