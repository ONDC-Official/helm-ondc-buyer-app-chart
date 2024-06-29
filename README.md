```shell
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo add spotahome https://spotahome.github.io/redis-operator
helm repo add bitnami oci://registry-1.docker.io/bitnamicharts
helm repo add elastic https://helm.elastic.co/
```

### 2. Update helm repo
```shell
helm repo update
```

### 3. Install helm
```shell
helm install ondc-buyer-app-release . -f values.yaml --namespace ondc-buyer-app-pre-prod
``` 

```shell
mkdir -p charts
curl -L -o charts/community-operator-0.9.0.tgz https://github.com/mongodb/helm-charts/releases/download/community-operator-0.9.0/community-operator-0.9.0.tgz
curl -L -o charts/redis-operator-3.2.9.tgz https://github.com/spotahome/redis-operator/releases/download/Chart-3.2.9/redis-operator-3.2.9.tgz
curl -L -o charts/rabbitmq-cluster-operator-4.3.1.tgz https://charts.bitnami.com/bitnami/rabbitmq-cluster-operator-4.3.1.tgz
curl -L -o charts/eck-operator-2.9.0.tgz https://helm.elastic.co/helm/eck-operator/eck-operator-2.9.0.tgz
```

```shell
kubectl create namespace ondc-prod-prod
```

```shell
# uninstall
helm uninstall ondc-buyer-app-release --namespace ondc-prod-prod
```

```shell
kubectl create secret generic my-mongodb-admin-password --from-literal=password='mongopass123' -n ondc-prod-prod
kubectl create secret generic my-mongodb-scram-credentials -n ondc-prod-prod \
  --from-literal=password='cGFzc3dvcmQ=' \
  --from-literal=scram-sha-1='cGFzc3dvcmQ=' \
  --from-literal=scram-sha-256='cGFzc3dvcmQ=' \
  --from-literal=scram-sha-1-salt='cGFzc3dvcmQ=' \
  --from-literal=scram-sha-256-salt='cGFzc3dvcmQ='
```

to update the values
```shell
 helm upgrade ondc-buyer-app-release . -f values.yaml --namespace ondc-prod-prod
```

dscribe crd
```shell
kubectl describe mongodbcommunity --namespace ondc-prod-prod
```

mongosh "mongodb+srv://my-user:password@example-mongodb-svc.mongodb.svc.cluster.local/admin?ssl=true"

kubectl get secret example-mongodb-admin-my-user -n ondc-prod-prod \
-o json | jq -r '.data | with_entries(.value |= @base64d)'