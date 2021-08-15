1. Terraformed some defaults

2. Helm install failed so ... added the following manual steps

1. install certificates

```bash
export PROJECT_ID=coder-pentest-0
gcloud iam service-accounts create dns01-pentest-solver --display-name "dns01-pentest-solver" --project=$PROJECT_ID 
gcloud projects add-iam-policy-binding $PROJECT_ID \
   --member serviceAccount:dns01-pentest-solver@$PROJECT_ID.iam.gserviceaccount.com \
   --role roles/dns.admin
gcloud iam service-accounts keys create key.json \
   --iam-account dns01-pentest-solver@$PROJECT_ID.iam.gserviceaccount.com
```

```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
```

```bash
vi cert-manager-issuer.yaml
kubectl apply -f cert-manager-issuer.yaml 
vi coder-certificate.yaml
kubectl apply -f coder-certificate.yaml 
helm install coder coder/coder -n coder -f ../coder-pentest-values.yaml 
```