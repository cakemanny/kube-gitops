GOPATH=$(shell go env GOPATH)
KIND=$(GOPATH)/bin/kind

help:
	@echo cluster
	@echo flux

.PHONY: cluster
cluster: cluster.yaml
	$(KIND) get clusters
	$(KIND) create cluster --config=cluster.yaml
