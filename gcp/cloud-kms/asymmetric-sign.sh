newline() {
  echo ""
}

export GCP_PROJECT=kms-example-328512
TF_DIR=~/experiments/infra-playground/gcp/cloud-kms/terraform
DIR=$(mktemp -d)
cd $DIR

PUBLIC_KEY_FILE=public-key.pub
MESSAGE_FILE=message.txt

echo "hello mr. president, this is from me." >> $MESSAGE_FILE

SIGNATURE_FILE=message.sig

gcloud kms asymmetric-sign \
  --project=$GCP_PROJECT \
  --version=$(terraform -chdir=$TF_DIR output -raw asymmetric_signing_key_version) \
  --key=$(terraform -chdir=$TF_DIR output -raw asymmetric_signing_key_name) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --location=$(terraform -chdir=$TF_DIR output -raw location)  \
  --input-file=$MESSAGE_FILE \
  --signature-file=$SIGNATURE_FILE \
  --digest-algorithm=sha256

gcloud kms keys versions get-public-key $(terraform -chdir=$TF_DIR output -raw asymmetric_signing_key_version) \
  --project=$GCP_PROJECT \
  --key=$(terraform -chdir=$TF_DIR output -raw asymmetric_signing_key_name) \
  --keyring=$(terraform -chdir=$TF_DIR output -raw key_ring) \
  --location=$(terraform -chdir=$TF_DIR output -raw location) >> $PUBLIC_KEY_FILE

echo "original message:"
cat $MESSAGE_FILE
newline

echo "message signature:"
cat $SIGNATURE_FILE
newline
newline

echo "verification:"
openssl dgst \
  -sha256 \
  -verify $PUBLIC_KEY_FILE \
  -signature $SIGNATURE_FILE \
  $MESSAGE_FILE
