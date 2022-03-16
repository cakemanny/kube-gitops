FLUX_DIR=../../workloads/flux/
GHUSER=cakemanny

manifests:
	mkdir -p $(FLUX_DIR)
	fluxctl install \
	--git-user=$(GHUSER) \
	--git-branch=master \
	--git-email=$(GHUSER)@users.noreply.github.com \
	--git-url=git@github.com:$(GHUSER)/kube-gitops \
	--git-path=namespaces,workloads \
	--namespace=flux -o $(FLUX_DIR)
