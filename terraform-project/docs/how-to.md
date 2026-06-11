# How-to: Validación, Aplicación y Limpieza

Esta guía explica cómo realizar tareas operativas clave en el proyecto Terraform.

## Cómo validar el código
Para asegurar que tu código tiene el formato correcto y la sintaxis es válida:
1. Formatea el código:
   ```bash
   terraform fmt -recursive
   ```
2. Valida la configuración:
   ```bash
   terraform validate
   ```

## Cómo aplicar la infraestructura
Para desplegar los recursos en el entorno actual (asegúrate de estar en el workspace correcto usando `terraform workspace show`):
```bash
terraform apply -var-file=env/<entorno>.tfvars
```

## Cómo limpiar y destruir la infraestructura
Este proyecto incluye una máquina virtual protegida con `prevent_destroy = true`. 
Si intentas ejecutar `terraform destroy -var-file=env/<entorno>.tfvars`, Terraform lanzará un error y detendrá la destrucción para proteger este recurso crítico.

### Pasos para una destrucción completa (Cleanup controlado):
1. **Explicación del fallo**: El recurso `azurerm_linux_virtual_machine.vm` en el módulo `compute` tiene el bloque `lifecycle { prevent_destroy = true }`. Terraform impide su eliminación por seguridad.
2. **Remover protección**: Edita el archivo `modules/compute/main.tf` y elimina o comenta el bloque `prevent_destroy = true`.
3. **Aplicar cambio**: Ejecuta de nuevo `terraform apply -var-file=env/<entorno>.tfvars` para actualizar el estado sin la protección.
4. **Destruir**: Ahora sí, ejecuta:
   ```bash
   terraform destroy -var-file=env/<entorno>.tfvars
   ```
