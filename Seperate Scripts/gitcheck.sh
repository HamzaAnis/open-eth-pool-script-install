#!/bin/bash

if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed.' >&2
  apt-get install curl
  exit 1
  else
  echo "Present"
fi
