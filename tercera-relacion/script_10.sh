#!/bin/bash


#-----------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para indicar que hay un error
function error() {
  echo -e "\e[1;38;5;1mEl valor para la variable 'x' no es un número, introduzca únicamente números\e[0m"
  exit 1
}


# Función para informar al usuario de la ecuación planteada
function informacion_ecuacion() {
  echo -e "\e[1mDada la siguiente ecuación:"
  echo -e "\e[38;5;135m3x² + 5x + 8\e[0m" && echo ""
  read -p "Introduzca el valor para la variable 'x': " X
  export X
}


# Función que calcula la ecuación
function calcular_ecuacion() {
  # Comprobación del contenido de la variable
  if [[ ${X} =~ [[:digit:]] ]]; then
    # Se calcula el exponente de x² mediante bc y se guarda en variable
    EXPONENTE=$( echo "${X}^2" | bc)

    # Se calcula la multiplicación del número "3" por el exponente guardado en variable
    PRIMERA_MULTIPLICACION=$( echo "3 * ${EXPONENTE}" | bc)

    # Se calcula la multipliación de "5" por el valor de "x"
    SEGUNDA_MULTIPLICACION=$( echo "5 * ${X}" | bc )
    
    # Se calcula la suma de las operaciones realizadas y se guarda en variable
    RESULTADO=$( echo "${PRIMERA_MULTIPLICACION} + ${SEGUNDA_MULTIPLICACION} + 8" | bc)
    
    # Se muestra el resultado de la ecuación al usuario
    echo -e "El resultado de la ecuación es: \e[1;38;5;105m${RESULTADO}\e[0m"

  else
    # Llamada a la función que indica que hay un error en el valor de 'x'
    error_variable
  fi
}


# Función principal
function main() {
  # Importación de módulos para el script
  source modules/script_10/help.sh

  if (( ${#} == 0 )); then
    # Llamada a la función para mostrar la ecuación y obtener el valor de "x"
    informacion_ecuacion
    
    # Llamada a la función que calcula el valor de la ecuación
    calcular_ecuacion
  
  elif (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función ayuda del script
      ayuda

    else
      # Llamada a la función que indica que hay un error en la petición de ayuda
      error_ayuda
    fi

  else
    # Llamada a la función que indica que no han de pasarse argumentos
    no_args
  fi
}


#-----------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi