#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get -qy autoremove
apt-get clean


rm -f /var/lib/apt/lists/* /var/lib/apt/lists/partial/* |true
rm -f /var/cache/apt/*.bin
rm -f /var/cache/apt/archives/*.deb || true
rm -f /var/cache/apt/archives/partial/* || true

rm -rf /var/log/installer

rm -f /var/lib/dhcp/*

find /var/log -type f -name "*.log" -exec truncate {} --size 0 \;
