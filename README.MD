# Atlantis on AWS EKS with Terraform

This project deploys [Atlantis](https://www.runatlantis.io/) to AWS using an EKS (Elastic Kubernetes Service) cluster, with infrastructure provisioned via Terraform and Atlantis installed via the official Helm chart.

---

## 📦 Infrastructure Components

This Terraform project provisions the following AWS resources:

- **VPC** – Custom Virtual Private Cloud with public/private subnets
- **EKS Cluster** – Managed Kubernetes cluster
- **EKS Node Group** – EC2 instances as worker nodes
- **IAM Roles** – For EKS nodes, cluster access, and Atlantis permissions
- **KMS Key** – Optional, for encryption (if enabled)
- **Helm Atlantis Chart** – Atlantis deployed into the cluster
- **Load Balancer** – Exposes Atlantis service externally
- **Secrets** – GitHub credentials provided to Atlantis via environment variables

---

## 🚀 Deployment Steps

### 1. Clone the Repository

```bash
git clone https://github.com/ausrys/devops.git
cd devops
terraform init
terraform apply
```

### 2. Access Atlantis UI

```bash
kubectl get svc -n atlantis
```

Look for the EXTERNAL-IP under the atlantis service. Open the IP in your browser to access Atlantis.

### 3. Access Atlantis UI

Additional info
Grant IAM User Access to EKS
Go to EKS → Clusters → Your Cluster → Access tab, and add your IAM user or role under Access Entries:

```json
{
  "type": "USER",
  "principalArn": "arn:aws:iam::<account-id>:user/<your-user-name>",
  "accessPolicies": [
    {
      "policyArn": "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    }
  ]
}
```

Enable EBS CSI Driver Permissions

To allow persistent volumes to bind correctly (e.g., for atlantis-data):

Go to IAM → Roles → Your NodeGroup Role

Attach this policy: AmazonEBSCSIDriverPolicy

### 4. Configure GitHub Webhook



In your GitHub repository:

Go to Settings → Webhooks → Add Webhook

Use:

Payload URL: http://<EXTERNAL-IP>/events

Content type: application/json

Secret: use the value you set for webhook_secret

Enable push and pull request events.

✅ Requirements
Terraform v1.3+

AWS CLI configured with appropriate permissions

kubectl

Helm (optional, for manual debug)

🧠 Tips
If terraform apply fails on Helm or aws-auth, ensure your local IAM user is listed in the aws_auth_roles.

You can monitor logs with:

```bash
kubectl logs -n atlantis deployment/atlantis
```