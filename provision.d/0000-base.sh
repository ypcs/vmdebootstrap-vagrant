#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

echo "I: Upgrade system..."
echo "#!/bin/sh\nexit 101\n" > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d
#echo Acquire::Languages "none" >/etc/apt/apt.conf.d/99translations
apt-get update
apt-get -qy dist-upgrade
rm -f /usr/sbin/policy-rc.d

