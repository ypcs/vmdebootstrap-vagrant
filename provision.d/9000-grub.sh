#!/bin/sh
set -e

echo "I: Set net.ifnames=0..."
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1\"quiet splash net.ifnames=0\"/g' /etc/default/grub

echo "I: Set GRUB timeout to 1..."
sed -i 's,^GRUB_TIMEOUT=5,GRUB_TIMEOUT=1,g' /etc/default/grub
#update-grub
