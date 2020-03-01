#!/bin/bash
#This bash script help setting up graphical display environment
#Please run as root
if [ $# -ne 1 ]
then
  echo "Please enter your local ip-address as a parameter"
else
  apt-get update
  apt-get install x11-xserver-utils
  echo "xserver-allow-tcp=true" >> /etc/lightdm/lightdm.conf 
  export DISPLAY=$1:0.0
  systemctl restart lightdm
  xhost +
fi


