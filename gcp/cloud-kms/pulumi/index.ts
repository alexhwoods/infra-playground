import * as pulumi from "@pulumi/pulumi";
import * as gcp from "@pulumi/gcp";

export const location = "us-east1";

const keyRing = new gcp.kms.KeyRing("keyring-1", {
  location,
});

export const symmetricKey = new gcp.kms.CryptoKey("key-1", {
  keyRing: keyRing.id,
  rotationPeriod: "100000s",
});

export const keyring = keyRing.name;
export const key = symmetricKey.name;
