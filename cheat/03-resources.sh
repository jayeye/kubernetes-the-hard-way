# Provisioning Compute Resources

cd ../terraform
terraform apply

gcloud compute config-ssh

SSHUSER=$(gcloud compute os-login describe-profile --format 'value(posixAccounts.username)')


terraform output -json > ../cheat/resources.json
cd ../cheat

GCP_PROJECT=$(jq -r '.controllers.value[0].project' < resources.json)
GCP_ZONE=$(jq -r '.controllers.value[0].zone' < resources.json)

KUBERNETES_PUBLIC_ADDRESS=$(jq -r '.public_address.value' < resources.json)
KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local



KWORKERS=($(jq -r '.workers.value[].name' < resources.json))
KCONTROLLERS=($(jq -r '.controllers.value[].name' < resources.json))
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
