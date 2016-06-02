#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get -qy install apt-transport-https net-tools rsync
