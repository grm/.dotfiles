#!/usr/bin/env bash

unamestr=`uname`

if [[ "$unamestr" == 'Darwin' ]]; then
  ./osx.sh
elif [[ "$unamestr" == 'Linux' ]]; then
  echo 'Linux not supported yet.'
fi
