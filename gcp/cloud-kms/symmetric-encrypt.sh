newline() {
  echo ""
}

export GCP_PROJECT=kms-example-328512
TF_DIR=~/experiments/infra-playground/gcp/cloud-kms/terraform
DIR=$(mktemp -d)
cd $DIR

INPUT_FILE=secret-file.txt

echo "On August 19th, 1981, two Russian-made Libyan Su-22 Fitters fired upon and were subsequently shot down by two U.S. F-14 Tomcats off the Libyan coast." >> $INPUT_FILE
echo "Libya, under Colonel Gaddafi, had claimed that the entire Gulf was their territory..." >> $INPUT_FILE

CIPHERTEXT_FILE=secret-file.encrypted
PLAINTEXT_FILE=secret-file.decrypted

gcloud kms encrypt --project=$GCP_PROJECT \
  --location=$(terraform -chdir=$TF_DIR output -raw location) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --key=$(terraform -chdir=$TF_DIR output -raw symmetric_key_name) \
  --plaintext-file=$INPUT_FILE \
  --ciphertext-file=$CIPHERTEXT_FILE

gcloud kms decrypt --project=$GCP_PROJECT \
  --location=$(terraform -chdir=$TF_DIR output -raw location) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --key=$(terraform -chdir=$TF_DIR output -raw symmetric_key_name) \
  --ciphertext-file=$CIPHERTEXT_FILE \
  --plaintext-file=$PLAINTEXT_FILE

echo "input file:"
cat $INPUT_FILE
newline

echo "encrypted file:"
cat $CIPHERTEXT_FILE
newline
newline


echo "decrypted file:"
cat $PLAINTEXT_FILE