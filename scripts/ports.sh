#!/bin/bash
if [[ -z $1 ]]; then
  sudo netstat -tuln
else
  sudo netstat -tuln | grep ":$1"
fi