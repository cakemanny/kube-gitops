

Installing flux v1 in order to test upgrading to v2

Create a `kind` k8s cluster on your local machine, see https://kind.sigs.k8s.io/

```
go install sigs.k8s.io/kind@v0.11.1 && $(go env GOPATH)/bin/kind create cluster
```


Install flux via these instructions
https://fluxcd.io/legacy/flux/tutorials/get-started/

```
kubectl create ns flux
```

```shell
export GHUSER="cakemanny"
fluxctl install \
--git-user=${GHUSER} \
--git-branch=master \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/kube-gitops \
--git-path=namespaces,workloads \
--namespace=flux | kubectl apply -f -
```

and adding the key from `fluxctl identity --k8s-fwd-ns flux` as a deployment
key to the repo at  https://github.com/cakemanny/kube-gitops/settings/keys

