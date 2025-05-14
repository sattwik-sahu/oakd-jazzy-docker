#!/usr/bin/bash


docker run --rm -it \
  --privileged \
  --net host \
  --ipc host \
  --pid host \
  -v /dev/bus/usb:/dev/bus/usb \
  --device-cgroup-rule='c 189:* rmw' \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix --name=$1 \
  sattwik21/oakd-jazzy:v1.0.2 \
  zsh

