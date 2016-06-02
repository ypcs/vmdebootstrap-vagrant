ARCH = $(shell dpkg --print-architecture)
DISTRIBUTIONS = wheezy jessie stretch sid
HTTP_PROXY_SETTING := $(shell nc -z -w 0 127.0.0.1 3142 && echo 'http_proxy=http://127.0.0.1:3142')
SIZE ?= 10G
VMDEBOOTSTRAP = /usr/sbin/vmdebootstrap
VMDEBOOTSTRAP_OPTIONS = --customize=$(CURDIR)/customize.sh --package=rsync

.PRECIOUS: %.qcow2 %.qcow2.gz

all:
	@echo "Usage: make <distribution>"
	@echo "Available distributions: $(DISTRIBUTIONS)"

%.gz: %
	(cat $< | gzip -) > $@ || ($(RM) $@; false)

%.qcow2: %.raw
	qemu-img convert -O qcow2 $< $@

%.raw:
	sudo \
		$(HTTP_PROXY_SETTING) \
		$(VMDEBOOTSTRAP) \
		$(VMDEBOOTSTRAP_OPTIONS) \
		--arch $(ARCH) \
		--distribution $* \
		--enable-dhcp \
		--grub \
		--hostname $* \
		--image $@ \
		--log $*.log \
		--package openssh-server \
		--package sudo \
		--size $(SIZE) \
		--verbose
	#\		|| (sudo $(RM) $@; false)
	sync
#	sudo chown $(USER) $@ $*.log


$(DISTRIBUTIONS): % : %.box

%.box: %/box.img
	cp Vagrantfile.in $*/Vagrantfile
	cp metadata.json.in $*/metadata.json
	cd $* && tar cvfz ../$@ ./box.img ./Vagrantfile ./metadata.json

%/box.img: %.qcow2
	mkdir $*
	ln $< $@

clean:
	$(RM) *.raw *.qcow2 *.gz *.log
	$(RM) -rf $(DISTRIBUTIONS) *.box


