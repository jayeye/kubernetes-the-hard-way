# Provisioning Compute Resources

cd ../terraform
terraform apply

gcloud compute config-ssh

SSHUSER=$(gcloud compute os-login describe-profile --format 'value(posixAccounts.username)')


terraform output -json > ../cheat/resources.json
cd ../cheat

KUBERNETES_PUBLIC_ADDRESS=$(jq -r '.public_address.value' < resources.json)

KWORKERS=($(jq -r '.workers.value[].name' < resources.json))
KCONTROLLERS=($(jq -r '.controllers.value[].name' < resources.json))
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
