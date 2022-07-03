#!/usr/bin/env zsh

set -e

if nc -G3 -w3 -z cloud.dev 22
then
  docker context use cloud.dev
else
  docker context use default
fi

