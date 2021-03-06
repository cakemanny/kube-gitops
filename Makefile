GOPATH=$(shell go env GOPATH)
KIND=$(GOPATH)/bin/kind

ORG=cakemanny

help:
	@echo targets:
	@grep '[^:]*:' Makefile | grep -v '^\.' | grep -v '^\t' | sed 's/:.*//' | sed 's/^/  /'


.PHONY: minikube
minikube:
	minikube start

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
	open https://github.com/$(ORG)/kube-gitops/settings/keys


.PHONY: flux2
flux2:
	kubectl apply -k clusters/kind/flux-system

.PHONY: flux2-key
flux2-key:
	flux create secret git flux-system --url=ssh://git@github.com/$(ORG)/kube-gitops
	@echo copy the above deployment key
	@sleep 1
	open https://github.com/$(ORG)/kube-gitops/settings/keys
	@echo you may need to run "flux reconcile source git flux-system" after
	@echo setting the key


.PHONY: istio
istio:
	find workloads/istio-system -type f -name '*.yaml' -exec kubectl apply -f '{}' \;

.PHONY:
clean:
	$(KIND) delete cluster
