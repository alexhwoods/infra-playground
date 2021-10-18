## Run the `app`
```bash
# create isolated python env
$ python3 -m venv env
$ source env/bin/activate

# Install deps.
$ cd app
$ pip install -r requirements.txt

# Go!
$ python main.py

# Test
$ curl http://localhost:8080
Hello World!%
```

## Deploy with `gcloud`
```bash
cd app

gcloud app deploy app.yaml --project=$GCP_PROJECT
gcloud app browse --project=$GCP_PROJECT
```


## How To in Terraform

## Related Examples
- [terraform-appengine](https://github.com/bhidalto/terraform-appengine)

