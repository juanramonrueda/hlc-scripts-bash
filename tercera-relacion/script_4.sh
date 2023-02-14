#!/bin/bash


#-------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento recibido 
export PRIMER_ARGUMENTO="$1"


#-------------------------------------------------------------------
# Declaración de función

# Función principal
function main() {
  # Se lista el contenido en una única columna ls -1
  # Mediante pipeline se pasa a awk para formatear la salida
  # en una única fila printf("%s:") y se pone ":" junto a %s
  # para separar mediante colon, después se pasa al fichero dado
  ls -1 | sort | awk '{printf("%s:", $0)}' > $PRIMER_ARGUMENTO
}


#-------------------------------------------------------------------
# Ejecución de la función

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi