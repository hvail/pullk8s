#!/bin/bash

## the default use Ubuntu 22.04.2 LTS

init(){
  sudo apt install update
  echo "Insert Microk8s"
  sudo snap install microk8s --class --channel=1.28
  echo "Insert Docker"
  sudo apt install docker.io
  echo "add current user and group "
  sudo usermod -a -G microk8s $USER
  sudo chown -f -R $USER ~/.kube
  echo "alias the generci command"
  alias kubectl='microk8s kubectl'
  alias ctr='microk8s ctr'
}

pull_images(){
  echo "download default images"
  pullk8s pull registry.k8s.io/pause:3.7 --microk8s
  pullk8s pull registry.k8s.io/metrics-server/metrics-server:v0.6.3 --microk8s
}

if [ "$1"x == "init"x ]
then
  init
  exit 0
fi

if [ "$1"x == "pull_images"x ]
then
  pull_images
fi

