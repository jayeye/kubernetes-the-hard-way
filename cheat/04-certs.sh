# Provisioning a CA and Generating TLS Certificates

## Certificate Authority


cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

openssl rsa -in ca-key.pem -noout -text
openssl x509 -in ca.pem -noout -text

### Distribute the Client and Server Certificates

for instance in $(cd ../terraform; terraform output -json | jq -r '.workers.value | @tsv'); do
  gcloud compute scp ca.pem ${instance}-key.pem ${instance}.pem ${instance}:~/
done

for instance in $(cd ../terraform; terraform output -json | jq -r '.controllers.value | @tsv'); do
  gcloud compute scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem ${instance}:~/
done
