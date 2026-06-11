# Tutorial: Desplegando Entornos con Terraform Workspaces

Este tutorial te guiará paso a paso para inicializar el proyecto y desplegar los entornos `dev` y `prod` utilizando Terraform Workspaces.

## Requisitos Previos
- Tener instalado Terraform (`>= 1.0.0`).
- Tener sesión iniciada en Azure (`az login`).
- Contar con un backend remoto configurado (Storage Account en Azure).

## Paso 1: Inicializar el proyecto
Primero, inicializamos el directorio de trabajo de Terraform. Esto descargará los proveedores necesarios y configurará el backend.
```bash
terraform init
```

## Paso 2: Crear el Workspace para Desarrollo (dev)
Creamos un nuevo workspace llamado `dev`:
```bash
terraform workspace new dev
```
O si ya existe, lo seleccionamos:
```bash
terraform workspace select dev
```

## Paso 3: Planificar el Despliegue en Dev
Generamos un plan de ejecución utilizando el archivo de variables de `dev`:
```bash
terraform plan -var-file=env/dev.tfvars
```

## Paso 4: Crear el Workspace para Producción (prod)
Repetimos el proceso para producción:
```bash
terraform workspace new prod
terraform plan -var-file=env/prod.tfvars
```

¡Felicidades! Has configurado y planificado exitosamente múltiples entornos utilizando Terraform Workspaces.
