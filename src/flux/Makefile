FLUX_DIR=../../workloads/flux/
GHUSER=cakemanny
ORG=cakemanny

HELM_OPERATOR_VERSION=v1.4.2
OPERATOR_DIR=$(FLUX_DIR)helm-operator

# TODO: we should actually specifiy the targets...
.PHONY: manifests
manifests:
	mkdir -p $(FLUX_DIR)
	fluxctl install \
	--git-user=$(GHUSER) \
	--git-branch=master \
	--git-email=$(GHUSER)@users.noreply.github.com \
	--git-url=git@github.com:$(ORG)/kube-gitops \
	--git-path=namespaces,workloads \
	--namespace=flux -o $(FLUX_DIR)


helm-operator:
	mkdir -p $(OPERATOR_DIR)
	helm repo add fluxcd https://charts.fluxcd.io
	curl https://raw.githubusercontent.com/fluxcd/helm-operator/$(HELM_OPERATOR_VERSION)/deploy/crds.yaml > $(OPERATOR_DIR)/flux-helm-operator-crds.yaml
	helm template helm-operator fluxcd/helm-operator --version $(HELM_OPERATOR_VERSION) --namespace flux --set helm.versions=v3 > $(OPERATOR_DIR)/flux-helm-operator-deployment.yaml
