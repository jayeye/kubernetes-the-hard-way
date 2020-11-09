# Generating the Data Encryption Config and Key

## The Encryption Config File


cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

for instance in ${KCONTROLLERS[@]}; do
  gcloud compute scp encryption-config.yaml ${instance}:~/
done
