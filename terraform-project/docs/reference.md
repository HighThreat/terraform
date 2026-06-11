# Referencia: Variables y Outputs

Esta sección documenta las variables de entrada y los valores de salida del módulo raíz.

## Variables de Entrada

| Nombre | Tipo | Descripción | Sensible |
|--------|------|-------------|----------|
| `location` | `string` | Región de Azure donde se desplegarán los recursos. | No |
| `admin_username` | `string` | Nombre de usuario administrador para las VMs. | No |
| `admin_password` | `string` | Contraseña para las VMs. | Sí |
| `vnet_address_space` | `list(string)` | Espacio de direcciones de la VNET. | No |
| `subnets` | `map(object)` | Mapa de subredes (incluye `address_prefixes` y `nsg_name`). | No |
| `vms` | `map(object)` | Mapa de VMs (incluye `vm_size` y `subnet_key`). | No |
| `storage_account_name` | `string` | Nombre base para la cuenta de almacenamiento. | No |
| `container_name` | `string` | Nombre del contenedor de blobs. | No |

## Valores de Salida (Outputs)

| Nombre | Descripción |
|--------|-------------|
| `public_ips` | Lista de direcciones IP públicas de las VMs creadas. |
| `vm_names` | Lista de nombres de las VMs creadas. |
| `vnet_id` | ID de la Red Virtual (VNET) creada. |
| `storage_account_name` | Nombre exacto de la cuenta de almacenamiento desplegada. |
