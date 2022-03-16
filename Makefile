GOPATH=$(shell go env GOPATH)
KIND=$(GOPATH)/bin/kind

help:
	@echo targets:
	@grep '[^:]*:' Makefile | grep -v '^\.' | grep -v '^\t' | sed 's/:.*//' | sed 's/^/  /'

.PHONY: cluster
cluster: cluster.yaml
	test -z "`$(KIND) get clusters -q`" && \
		$(KIND) create cluster --config=cluster.yaml || exit 0

.PHONY: flux
flux: workloads/flux/*.yaml
	cat $^ | kubectl apply -f -
	kubectl rollout status deployment/flux -nflux

.PHONY: flux-key
flux-key:
	fluxctl identity --k8s-fwd-ns=flux | pbcopy
	open https://github.com/cakemanny/kube-gitops/settings/keys

.PHONY: istio
istio:
	find workloads/istio-system -type f -name '*.yaml' -exec kubectl apply -f '{}' \;

.PHONY:
clean:
	$(KIND) delete cluster
