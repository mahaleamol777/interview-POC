# interview-POC
interview-assignment


# AKS Microservice + Terraform + Azure DevOps sample

## What this repo contains
- `terraform/` : creates resource group, VNet, subnet, ACR, AKS, role assignment for ACR pull.
- `app/` : sample Node.js microservice + Dockerfile.
- `k8s/` : Kubernetes manifests (deployment/service/hpa).
- `azure-pipelines.yml` : Azure DevOps pipeline that scans Terraform (Checkov), applies Terraform, builds & pushes Docker image to ACR, deploys to AKS, installs Prometheus & Grafana via Helm.
- `scripts/` : Grafana export script.

## Assumptions
1. You have an Azure subscription and permissions to create RG, AKS, ACR, role assignments.
2. You will create an Azure DevOps service connection named `AzureServiceConnection`.
3. The pipeline will run on `main` branch.
4. Terraform remote state is optional; by default local state is used. For production configure remote backend (Azure Storage).

## Quick setup steps (high level)
1. Fork/clone repo.
2. Create Azure DevOps service connection `AzureServiceConnection`.
3. (Optional) Create Terraform backend storage account & configure `backend.tf`.
4. In Azure DevOps pipeline variables set sensitive values: `GRAFANA_ADMIN_PASSWORD`.
5. Run pipeline:
   - Terraform scan (Checkov) will run
   - Terraform apply will create AKS & ACR
   - Build & push will build image and push to ACR
   - Deploy stage will apply k8s manifests
   - Monitoring installs Prometheus & Grafana
6. Use `az aks get-credentials` & `kubectl get svc` to find service IPs. Grafana is accessible via the Grafana service (clusterIP) — use port-forward or expose via LoadBalancer/ingress if you want public access.

## Security scan results
- Checkov output is saved in pipeline logs. Address top severity items before promoting to production.

## Design decisions
- ACR + AKS with managed identity and AcrPull role to avoid storing registry credentials.
- kube-prometheus-stack for integrated Prometheus + Grafana + node exporters.
- Terraform manages infra only; K8s resources are applied in pipeline with kubectl.
