## Actually

With the current state of this repo.
```
make cluster
make flux
make flux-key
```
This should be enough to get to the point of having flux v1 installed properly.


## Installing flux v1 in order to test upgrading to v2

Create a `kind` k8s cluster on your local machine, see https://kind.sigs.k8s.io/

```
go install sigs.k8s.io/kind@v0.11.1
$(go env GOPATH)/bin/kind create cluster --config=cluster.yaml
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


## Install flux helm operator
See [src/flux/Makefile](src/flux/Makefile)
```
make -C src/flux helm-operator
```


## Installing flux v2

Need flux CI
```
brew install fluxcd/tap/flux
```

Stop flux v1 syncing
```shell
k scale deployment flux -nflux --replicas=0
```

https://github.com/settings/tokens

```shell
export GITHUB_TOKEN=...
flux bootstrap github \
  --owner=cakemanny \
  --repository=kube-gitops \
  --branch=master \
  --path=clusters/kind \
  --personal
```

or `flux install --export > clusters/kind/flux-system/gotk-components.yaml`

then set up additional Git sources
