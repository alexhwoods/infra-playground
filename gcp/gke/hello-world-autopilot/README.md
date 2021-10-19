### Get the credentials
```bash
gcloud container clusters get-credentials \
  --region=$(terraform output -raw region) \
  --project=$GCP_PROJECT \
  $(terraform output -raw cluster_name)
```

```bash
# Get rid of that ugly context name GCP puts by default
$ k ctx $(terraform output -raw cluster_name)=$(k ctx -c)
$ k ctx -c
dialga-e0116ea

# Run a pod
$ k run nginx --image=nginx

# if we wanna be sure we're using the right context
$ k run nginx --image=nginx --context=$(terraform output -raw cluster_name)
```


### Cleanup
```bash
$ k ctx -u && k ctx -d $(terraform output -raw cluster_name)
$ terraform destroy
```
