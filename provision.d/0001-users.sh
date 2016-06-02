#!/bin/sh
set -e

echo "I: Set password for user 'root' to 'vagrant'..."
echo "root:vagrant" |chpasswd

echo "I: Add user 'vagrant' with password 'vagrant'..."
useradd --create-home --user-group --shell /bin/bash --uid 1000 vagrant
echo "vagrant:vagrant" |chpasswd

echo "I: Add SSH key for vagrant..."
mkdir -p /home/vagrant/.ssh
chmod 0700 /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >/home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant

echo "I: Allow sudo without password for user 'vagrant'..."
apt-get -qy install sudo
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
