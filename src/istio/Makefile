VERSION=1.10.6
ARCH=arm64
OS=osx
REV=default

ARCHIVE=istioctl-$(VERSION)-$(OS)-$(ARCH).tar.gz
INSTALL_DIR=../../workloads/istio-system/$(REV)/

ifneq "$(REV)" "default"
  OPTIONS=--set revision=$(REV)
endif

.PHONY: controlplane
controlplane: bin/istioctl-$(VERSION)
	mkdir -p $(INSTALL_DIR)
	bin/istioctl-$(VERSION) manifest generate $(OPTIONS) -o $(INSTALL_DIR)


bin/istioctl-$(VERSION):
	mkdir -p bin
	curl -O -L https://github.com/istio/istio/releases/download/$(VERSION)/$(ARCHIVE)
	curl -O -L https://github.com/istio/istio/releases/download/$(VERSION)/$(ARCHIVE).sha256
	cat $(ARCHIVE).sha256
	openssl sha256 < $(ARCHIVE)
	test `openssl sha256 < $(ARCHIVE)` = `cut -c -64 $(ARCHIVE).sha256`
	tar -xvf $(ARCHIVE) -C bin
	mv bin/istioctl bin/istioctl-$(VERSION)
