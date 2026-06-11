# Explicación: Arquitectura y Diseño de Módulos

El proyecto está diseñado bajo una arquitectura modular Enterprise, recomendada para mantener el código DRY (Don't Repeat Yourself) y facilitar la gestión de entornos con Terraform Workspaces.

## Estructura de Módulos

Hemos separado la infraestructura en cuatro dominios principales:

1. **`rg` (Resource Group)**: Gestiona el ciclo de vida del grupo de recursos que contendrá todos los elementos del entorno.
2. **`network`**: Abstrae la creación de la Virtual Network, las subredes y los Network Security Groups. Utiliza `for_each` para iterar sobre un `map(object)` y crear múltiples subredes de forma dinámica, asociándolas a sus respectivos NSGs.
3. **`compute`**: Encargado del aprovisionamiento de las máquinas virtuales Linux. Al igual que la red, utiliza `for_each` sobre un `map(object)` para crear múltiples VMs basadas en la configuración de `tfvars`. Implementa una regla de ciclo de vida (`prevent_destroy = true`) para salvaguardar recursos críticos.
4. **`storage`**: Proporciona la cuenta de almacenamiento y el contenedor de blobs.

## Gestión de Entornos

En lugar de duplicar carpetas (ej. copiar y pegar todo para `dev` y `prod`), utilizamos **Terraform Workspaces**. 
El código de infraestructura es uno solo (`main.tf` en el directorio raíz), pero su comportamiento cambia gracias a dos mecanismos:
- **`terraform.workspace`**: Variable nativa que nos permite generar nombres únicos (e.g., `vnet-globex-dev`).
- **Archivos `.tfvars` separados**: `env/dev.tfvars` y `env/prod.tfvars` inyectan los valores específicos (tamaño de VM, rangos de IP) para cada entorno.
