# Bootstrap del backend

Este directorio crea los recursos necesarios para el backend remoto de Terraform (Resource Group, Storage Account y Blob Container). Los nombres usan prefijos `leostorage` y `leocontainer`.

Pasos:

```bash
# Autentica con Azure CLI y selecciona la suscripción estudiante
az login
az account set --subscription "<student-subscription-id>"

cd terraform-ex/bootstrap
terraform init
terraform apply

# Anota los valores de salida: resource group, storage account y container
```

Luego, en la carpeta raíz `terraform-ex`, ejecuta:

```bash
terraform init -migrate-state \
  -backend-config="resource_group_name=$(terraform output -raw backend_resource_group)" \
  -backend-config="storage_account_name=$(terraform output -raw backend_storage_account)" \
  -backend-config="container_name=$(terraform output -raw backend_container)" \
  -backend-config="key=terraform-ex.tfstate"
```
