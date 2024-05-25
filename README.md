# wihomet

## Preparation

```bash
aws s3api create-bucket --bucket wihomet-terraform-state-wiliot --region us-east-1
aws dynamodb create-table --table-name wihomet-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1
aws iam create-open-id-connect-provider --url 'https://token.actions.githubusercontent.com' --thumbprint-list "6938fd4d98bab03faadb97b34396831e3780aea1" --client-id-list 'sts.amazonaws.com'
aws iam create-role --role-name GitHubAction-AssumeRoleWithAction --assume-role-policy-document file://./trustpolicyforGitHubOIDC.json
aws dynamodb put-resource-policy --resource-arn arn:aws:dynamodb:us-east-1:092988563851:table/wihomet-lock-table --policy file://dynamodb_table_policy.json

```

## Deployment

The application is deployed using GitHub Actions. The workflow is defined in the .github/workflows/action.yaml file. It includes steps to deploy the infrastructure using Terraform, build the Docker image, and install the Helm chart.

## Not realized

Service not exposed to world, stuck a bit with igress/load balancer/helm
All actions currently in manual mode.
