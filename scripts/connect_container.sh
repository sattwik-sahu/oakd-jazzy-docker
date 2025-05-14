#!/usr/bin/bash

docker exec -it \
  -e "TERM=xterm-256color" \
  $1 zsh

