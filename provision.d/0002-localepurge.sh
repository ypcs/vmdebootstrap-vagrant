#!/bin/sh
set -e

export DEBIAN_FRONTEND="noninteractive"

TEMPFILE="$(mktemp --tmpdir)"

cat >${TEMPFILE} << EOF
localepurge     localepurge/dontbothernew       boolean false
localepurge     localepurge/quickndirtycalc     boolean true
localepurge     localepurge/mandelete   boolean true
localepurge     localepurge/use-dpkg-feature    boolean false
localepurge     localepurge/showfreedspace      boolean true
localepurge     localepurge/verbose     boolean false
localepurge     localepurge/remove_no   note    
localepurge     localepurge/nopurge     multiselect     en, en_US, en_US.UTF-8, fi, fi_FI.UTF-8
localepurge     localepurge/none_selected       boolean false
EOF

debconf-set-selections < ${TEMPFILE}

apt-get -qy install localepurge

