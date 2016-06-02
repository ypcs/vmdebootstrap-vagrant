#!/bin/sh
set -e

FILESYSTEM="$1"
HOSTNAME="$2"

if [ -z "${FILESYSTEM}" ]
then
    echo "usage: $0 <root-fs>"
    exit 1
fi

mkdir -p "${FILESYSTEM}/root/provision"
cp provision.d/*.sh "${FILESYSTEM}/root/provision/"

for f in `ls "${FILESYSTEM}/root/provision/"*.sh`
do
    [ ! -x "${f}" ] && continue
    BFILE=`basename "${f}"`
    echo "I: Running provisioning script ${BFILE}..."
    chroot "${FILESYSTEM}" "/root/provision/${BFILE}"
done

if [ -n "${HOSTNAME}" ]
then
    echo "${HOSTNAME}" >"${FILESYSTEM}/etc/hostname"
    echo "127.0.2.1 ${HOSTNAME}" >>"${FILESYSTEM}/etc/hosts"
fi

rm -rf "${FILESYSTEM}/root/provision"
