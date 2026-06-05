# terraform-ex

Ejercicio de Terraform para Azure con estructura mínima reutilizable, backend remoto, workspaces y soporte para importación.

## Qué despliega

- 1 Resource Group
- 1 VNET
- 2 subnets
- 1 NSG
- Asociación NSG por subnet
- 1 Storage Account
- 1 Blob Container

## Requisitos previos

- Azure CLI instalado y autenticado
- Suscripción de estudiante seleccionada
- Backend remoto Azure Storage proporcionado por el profesor

## Backend remoto

Completa el backend con los datos del profesor y luego ejecuta:

```bash
terraform init -migrate-state \
  -backend-config="resource_group_name=<rg-backend>" \
  -backend-config="storage_account_name=<sa-backend>" \
  -backend-config="container_name=<container-backend>" \
  -backend-config="key=terraform-ex.tfstate"
```

## Workspaces

El proyecto está preparado para `dev` y `prod`.

```bash
terraform workspace new dev
terraform workspace select dev
terraform plan
terraform apply

terraform workspace new prod
terraform workspace select prod
terraform plan
terraform apply
```

## Import

La carpeta incluye una declaración opcional para importar un Resource Group existente cuando se defina `import_existing_resource_group_name`.

Ejemplo:

```bash
terraform import azurerm_resource_group.imported[0] /subscriptions/<sub-id>/resourceGroups/<rg-name>
```

## State

Comandos útiles:

```bash
terraform state list
terraform state show azurerm_virtual_network.this
```

## Cleanup

```bash
terraform destroy
```
