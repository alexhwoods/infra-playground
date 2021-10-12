newline() {
  echo ""
}

export GCP_PROJECT=kms-example-328512
TF_DIR=~/experiments/infra-playground/gcp/cloud-kms/terraform
DIR=$(mktemp -d)
cd $DIR

PUBLIC_KEY_FILE=public-key.pub
INPUT_FILE=dek.key

echo "487ab0d9-eb31-4740-b677-f2c5fa65fffa" >> $INPUT_FILE

CIPHERTEXT_FILE=dek.key.encrypted
PLAINTEXT_FILE=dek.key.decrypted

gcloud kms keys versions get-public-key $(terraform -chdir=$TF_DIR output -raw asymmetric_key_version) \
  --project=$GCP_PROJECT \
  --key=$(terraform -chdir=$TF_DIR output -raw asymmetric_key_name) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --location=$(terraform -chdir=$TF_DIR output -raw location) >> $PUBLIC_KEY_FILE

openssl pkeyutl -in dek.key \
  -encrypt -pubin -inkey $PUBLIC_KEY_FILE \
  -pkeyopt rsa_padding_mode:oaep \
  -pkeyopt rsa_oaep_md:sha256 \
  -pkeyopt rsa_mgf1_md:sha256 > $CIPHERTEXT_FILE


gcloud kms asymmetric-decrypt \
  --project=$GCP_PROJECT \
  --version=$(terraform -chdir=$TF_DIR output -raw asymmetric_key_version) \
  --key=$(terraform -chdir=$TF_DIR output -raw asymmetric_key_name) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --location=$(terraform -chdir=$TF_DIR output -raw location)  \
  --ciphertext-file=$CIPHERTEXT_FILE \
  --plaintext-file=$PLAINTEXT_FILE

echo "original DEK:"
cat $INPUT_FILE
newline

echo "encrypted (\"wrapped\") DEK:"
cat $CIPHERTEXT_FILE
newline
newline


echo "decrypted DEK:"
cat $PLAINTEXT_FILE
