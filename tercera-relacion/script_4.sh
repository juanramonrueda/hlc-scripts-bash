#!/bin/bash


#--------------------------------------------------------------------------------------
# Declaración de variables

# Conversión del primer argumento recibido 
export PRIMER_ARGUMENTO="$1"


#--------------------------------------------------------------------------------------
# Declaración de función

# Función principal
function main() {
  if [[ $# != 1 ]]; then
    # Llamada al script que contiene la explicación del funcionamiento del script
    source how_works_script_1.sh
  
  # En el caso de que el número de argumentos sea correcto, entra al ELSE
  else
    # Se lista el contenido en una única columna ls -1
    # Mediante pipeline se pasa a awk para formatear la salida en una única fila
    # mediante printf("%s:") y se pone ":" junto a %s para separar mediante semicolon
    # y después se pasa al fichero dado
    ls -1 | sort | awk '{printf("%s:", $0)}' > $PRIMER_ARGUMENTO
  fi
}


#--------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi