#!/bin/bash


#----------------------------------------------------------------------------------------
# Declaración de función

# Función para informar al usuario de la ecuación planteada
function informacion_ecuacion() {
  echo -e "\e[1mDada la siguiente ecuación:"
  echo -e "\e[38;5;135m3x² + 5x + 8\e[0m" && echo ""
  read -p "Introduzca el valor para la variable 'x': " X
}

function calcular_ecuacion() {
  # Se calcula el exponente de x² mediante bc y se guarda en variable
  EXPONENTE=$( echo "$X^2" | bc)

  # Se calcula la multiplicación del número "3" por el exponente guardado en variable
  PRIMERA_MULTIPLICACION=$( echo "3 * $EXPONENTE" | bc)

  # Se calcula la multipliación de "5" por el valor de "x"
  SEGUNDA_MULTIPLICACION=$( echo "5 * $X" | bc )
  
  # Se calcula la suma de las operaciones realizadas y se guarda en variable
  RESULTADO=$( echo "$PRIMERA_MULTIPLICACION + $SEGUNDA_MULTIPLICACION + 8" | bc)
  
  # Se muestra el resultado de la ecuación al usuario
  echo -e "El resultado de la ecuación es: \e[1;38;5;105m$RESULTADO\e[0m"
}

# Función principal
function main() {
  # Llamada al script que contiene la función para limpiar la pantalla
  source clear_screen.sh

  # Llamada a la función para mostrar la ecuación y obtener el valor de "x"
  informacion_ecuacion
  
  # Llamada a la función que calcula el valor de la ecuación
  calcular_ecuacion
}


#----------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi