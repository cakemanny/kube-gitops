VERSION=1.10.6
ARCH=arm64
OS=osx

ARCHIVE=istioctl-$(VERSION)-$(OS)-$(ARCH).tar.gz


.PHONY: controlplane
controlplane: bin/istioctl-$(VERSION)
	mkdir -p ../../workloads/istio-system
	bin/istioctl-$(VERSION) manifest generate -o ../../workloads/istio-system/


bin/istioctl-$(VERSION):
	mkdir -p bin
	curl -O -L https://github.com/istio/istio/releases/download/$(VERSION)/$(ARCHIVE)
	curl -O -L https://github.com/istio/istio/releases/download/$(VERSION)/$(ARCHIVE).sha256
	cat $(ARCHIVE).sha256
	openssl sha256 < $(ARCHIVE)
	test `openssl sha256 < $(ARCHIVE)` = `cut -c -64 $(ARCHIVE).sha256`
	tar -xvf $(ARCHIVE) -C bin
	mv bin/istioctl bin/istioctl-$(VERSION)
