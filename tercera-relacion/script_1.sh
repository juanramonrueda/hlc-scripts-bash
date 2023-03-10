#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Declaración de la variable como "global" para entrar al bucle de la función principal
export X=0

# Se inicializa la variable como "global" para los campos del cut -d ... -f
export CAMPOS_CUT=1


#----------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que contiene el flujo loop del programa
function loop_execution() {
  # Mientras el número sea distinto de 99, el bucle continuará
  while (( ${X} != 99 )); do
    # Llamada a la función para limpiar la pantalla
    clear_screen

    # Petición de valores al usuario
    read -p 'Introduzca el primer número (si quiere finalizar introduzca el 99): ' X

    # Si el primer número es distinto de 99, pedirá el segundo para evitar continuar en el caso de que sea 99
    if (( ${X} != 99 )); then
      read -p 'Introduzca el segundo número: ' Y

      # Si el primer número es mayor que el segundo, realizará un intercambio de variables
      if (( ${X} > ${Y} )); then
        # Intercambio de variables mediante una variable auxiliar
        AUX=${X}
        X=${Y}
        Y=${AUX}
      fi
      
      # Recorrido desde el primer número dado hasta el segundo número dado por el usuario
      for INCREMENTO in $(seq ${X} ${Y})
      do
        # Variable contadora para conocer la cantidad de vueltas del bucle
        CONTADOR=$(( ${CONTADOR} + 1 ))

        # Se obtiene en un array el rango que hay entre los dos números del usuario
        ARRAY+=( "${INCREMENTO}/${Y}, " )
      done
      
      # Se usa la variable contadora del anterior bucle para obtener la cantidad de campos para el comando cut -f
      for CONTEO in $(seq 1 ${CONTADOR})
      do
        # Obtención en variable de los campos a obtener para el comando cut -f
        CAMPOS_CUT="${CAMPOS_CUT},${CONTEO}"
      done

      # Obtención en variable de los números comprendidos entre el primero y el segundo
      RESULTADO=$( echo "${ARRAY[@]}" | cut -d "," -f ${CAMPOS_CUT} )

      # Se muestra por pantalla los números de la variable anterior
      echo -e "\e[38;5;117m${RESULTADO}\e[38;5;99m" && sleep 1s && read -n 1 -p "Pulse una tecla para continuar..."
      echo -e "\e[0m"
    fi

    # Se limpia la variable que hace de array para no almacenar todos los resultados
    ARRAY=()
  done
}


# Función principal
function main() {
  # Importación de módulos necesarios para el script
  source modules/script_1/clear_screen.sh
  source modules/script_1/help.sh

  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      ayuda
    else
      error_ayuda
    fi

  else
    # Llamada a la función que contiene el flujo del programa
    loop_execution
  fi
}


#----------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi