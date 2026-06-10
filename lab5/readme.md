# Laboratorio 5 — Creación y uso de módulos

Este laboratorio demuestra cómo estructurar y construir una arquitectura de infraestructura modular y profesional en Azure utilizando Terraform.

El objetivo principal es implementar la reutilización de código mediante la creación de módulos locales (`rg`, `network` y `vm`), conectándolos en el módulo raíz y aplicando versionado y buenas prácticas.

---

## Estructura del Proyecto

El proyecto sigue una estructura limpia y desacoplada:

```text
lab5/
├── main.tf                 # Módulo raíz que instancia los submódulos
├── variables.tf            # Variables globales del módulo raíz
├── outputs.tf              # Outputs consolidados del módulo raíz
├── providers.tf            # Configuración de proveedores y versión de Terraform
├── terraform.tfvars        # Valores de variables para pruebas
├── modules/
│   ├── rg/                 # Módulo de Resource Group
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── network/            # Módulo de Red (VNet, Subnets, NSGs)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vm/                 # Módulo de Cómputo (VM, NIC, IP Pública)
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── tests/
    └── lab5_unit_test.tftest.hcl  # Pruebas unitarias automatizadas (Plan-only con Mocks)
```

---

## Flujo de Variables y Dependencias

Los módulos están encadenados pasando los `outputs` de un módulo como `inputs` del siguiente:

```mermaid
graph LR
    RG[Módulo RG] -->|rg_name, location| Network[Módulo Network]
    RG -->|rg_name, location| VM[Módulo VM]
    Network -->|subnet_ids[0]| VM
```

1. **Módulo RG** crea el Resource Group y expone su nombre, ID y ubicación.
2. **Módulo Network** recibe el nombre y la ubicación del Resource Group para crear la Virtual Network, las Subnets y los Network Security Groups. Expone la lista de IDs de las subnets creadas.
3. **Módulo VM** recibe el nombre y la ubicación del Resource Group, además del ID de la primera subnet (`subnet_ids[0]`), para crear la IP pública, la NIC, la cuenta de almacenamiento de diagnósticos y la máquina virtual Linux.

---

## Cómo Ejecutar el Proyecto

### 1. Inicialización
Descarga los proveedores requeridos (AzureRM) e inicializa la estructura de módulos locales:
```bash
terraform init
```

### 2. Validación
Verifica la sintaxis, tipos y lógica de la configuración de Terraform:
```bash
terraform validate
```

### 3. Formateo
Asegura que todo el código siga las directrices oficiales de estilo de HashiCorp:
```bash
terraform fmt -recursive
```

### 4. Pruebas Automatizadas
Ejecuta las pruebas unitarias locales utilizando proveedores simulados (Mock Providers), validando la lógica de la configuración sin necesidad de credenciales de Azure ni aprovisionamiento de infraestructura real:
```bash
terraform test
```

### 5. Planificación (Opcional - Requiere credenciales de Azure)
Genera el plan de ejecución real:
```bash
terraform plan
```
