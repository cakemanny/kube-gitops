GOPATH=$(shell go env GOPATH)
KIND=$(GOPATH)/bin/kind

help:
	@echo cluster
	@echo flux

.PHONY: cluster
cluster: cluster.yaml
	test -z "`$(KIND) get clusters -q`" && \
		$(KIND) create cluster --config=cluster.yaml || exit 0

.PHONY:
flux: workloads/flux/*.yaml
	cat $^ | kubectl apply -f -
	kubectl rollout status deployment/flux -nflux
