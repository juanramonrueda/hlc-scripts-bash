#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para explicar al usuario cómo funciona el script
function main() {
  echo -e "\e[1;38;5;124mEste script se encarga de validar correos electrónicos"
  echo "Para hacer uso del script, pase un correo electrónico como argumento para hacer su validación:"
  echo -e "${0} correo@ejemplo.net"

  # Salida no exitosa
  exit 1
}


#-------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

main