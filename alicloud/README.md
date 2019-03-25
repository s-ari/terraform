# Setup authentications

## Export environment variables

### Authentications not have to wirte in tffiles.

* Access key
* Secret key
* Prefixs
* SSH key file name

```
export TF_VAR_access_key=""
export TF_VAR_secret_key=""
export TF_VAR_region=""
export TF_VAR_ssh_key=""
export TF_VAR_prefix=""
```

# Run terraform commands

* Change environment commands using workspace

```
terraform workspace new <Environment>
terraform workspace list
terraform workspace select <Environment>
```
