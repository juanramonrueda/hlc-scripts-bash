#!/bin/bash


#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Variable que contiene una expresión regular para comprobar que se introducen únicamente números (enteros, decimales...)
COMPROBACION_NUMERO='^[-+]?[0-9]+\.?[0-9]*$'

# Variable que contiene una expresión regular para comprobar que únicamente se introducen operadores matemáticos
COMPROBACION_OPERACION='[%*+-/]'

# Se pasa el contenido del primer argumento recibido a otra variable y se convierte en "global" con export para las funciones
export PRIMER_ARGUMENTO="${1}"

# Se pasa el contenido del segundo argumento recibido a otra variable y se convierte en "global" con export para las funciones
export SEGUNDO_ARGUMENTO="${2}"

# Se pasa el contenido del terce argumento recibido a otra varaible y se convierte en "global" con export para las funciones
export TERCER_ARGUMENTO="${3}"


#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para realizar la suma de los dos argumentos
function suma() {
  RESULTADO=$( echo "(${PRIMER_ARGUMENTO} + ${SEGUNDO_ARGUMENTO})" | bc -l )
  echo -e "\e[38;5;154mSe ha realizado la suma de ambos números --> \e[1m${PRIMER_ARGUMENTO} + ${SEGUNDO_ARGUMENTO} = ${RESULTADO}\e[0m"
  exit 0
}


# Función para realizar la resta de los dos argumentos
function resta() {
  RESULTADO=$( echo "(${PRIMER_ARGUMENTO} - ${SEGUNDO_ARGUMENTO})" | bc -l )
  echo -e "\e[38;5;154mSe ha realizado la resta de ambos números --> \e[1m${PRIMER_ARGUMENTO} - ${SEGUNDO_ARGUMENTO} = ${RESULTADO}\e[0m"
  exit 0
}


# Función para realizar la multiplicación de los dos argumentos
function multiplicacion() {
  RESULTADO=$( echo "(${PRIMER_ARGUMENTO} * ${SEGUNDO_ARGUMENTO})" | bc -l )
  echo -e "\e[38;5;154mSe ha realizado la multiplicación de ambos números --> \e[1m${PRIMER_ARGUMENTO} * ${SEGUNDO_ARGUMENTO} = ${RESULTADO}\e[0m"
  exit 0
}


# Función para realizar la división de los dos argumentos y obtener el cociente
function division() {
  RESULTADO=$( echo "(${PRIMER_ARGUMENTO} / ${SEGUNDO_ARGUMENTO})" | bc -l )
  echo -e "\e[38;5;154mSe ha realizado la división de ambos números para obtener el cociente --> \e[1m${PRIMER_ARGUMENTO} / ${SEGUNDO_ARGUMENTO} = ${RESULTADO}\e[0m"
  exit 0
}


# Función para realizar la división de los dos argumentos y obtener el resto
function modulo() {
  RESULTADO=$( echo "(${PRIMER_ARGUMENTO} % ${SEGUNDO_ARGUMENTO})" | bc -l )
  echo -e "\e[38;5;154mSe ha realizado la división de ambos números para obtener el resto --> \e[1m${PRIMER_ARGUMENTO} % ${SEGUNDO_ARGUMENTO} = ${RESULTADO}\e[0m"
  exit 0
}


# Función para realizar las operaciones matemáticas
function calculadora() {
  # En el caso de que el tercer argumento sea para realizar la suma, llamará a la función que realiza la operación
  if [[ ${TERCER_ARGUMENTO} == '+' ]]; then
    suma

  # En el caso de que el tercer argumento sea para realizar la resta, llamará a la función que realiza la operación
  elif [[ ${TERCER_ARGUMENTO} == '-' ]]; then
    resta

  # En el caso de que el tercer argumento sea para realizar la multiplicación, llamará a la función que realiza la operación
  elif [[ ${TERCER_ARGUMENTO} == '*' ]]; then
    multiplicacion

  # En el caso de que el tercer argumento sea para realizar la división y obtener el cociente, llamará a la función que realiza la operación
  elif [[ ${TERCER_ARGUMENTO} == '/' ]]; then
    if (( ${SEGUNDO_ARGUMENTO} != 0 ));then
      division

    # En el caso de que el tercer argumento sea la división y el segundo argumento un 0, saldrá de la ejecución
    else
      error_division
    fi

  # En el caso de que el tercer argumento sea para realizar la división y obtener el resto, llamará a la función que realiza la operación
  elif [[ ${TERCER_ARGUMENTO} == '%' ]]; then
    if (( ${SEGUNDO_ARGUMENTO} != 0 ));then
      modulo

    # En el caso de que el tercer argumento sea la división y el segundo argumento un 0, saldrá de la ejecución
    else
      error_division
    fi
  fi
}


# Función para realizar comprobaciones de los argumentos mediante patrones y llamar al resto de funciones
function check_args() {
  # Comprobación de que el primer argumento dado es un número
  if [[ ${PRIMER_ARGUMENTO} =~ ${COMPROBACION_NUMERO} ]]; then
          
    # Comprobación de que el segundo argumento dado es un número
    if [[ ${SEGUNDO_ARGUMENTO} =~ ${COMPROBACION_NUMERO} ]]; then
              
      # Comprobación de que el tercer argumento dado es una expresión utilizada en matemáticas
      if [[ ${TERCER_ARGUMENTO} =~ ${COMPROBACION_OPERACION} ]]; then
        calculadora

      # Mensaje de que el tercer argumento dado no es un símbolo de expresión matemática
      else
        # Uso del backslash para "escapar" las comillas dobles
        echo -e "\e[38;5;196mEl tercer argumento dado, \"${TERCER_ARGUMENTO}\", no es una expresión matemática\e[0m"
      fi
  
    # Mensaje de que el segundo argumento dado no es un número    
    else
      echo -e "\e[38;5;196mEl segundo argumento dado, \"${SEGUNDO_ARGUMENTO}\", no es un número\e[0m"
    fi

  # Mensaje de que el primer argumento dado no es un número
  else
    echo -e "\e[38;5;196mEl primer argumento dado, \"${PRIMER_ARGUMENTO}\", no es un número\e[0m"
  fi
}


# Función principal para validar los argumentos dados
function main() {
  # Importación de scripts necesarios 
  source modules/script_1/help.sh

  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del script help.sh
      ayuda
      
    else
      # Llamada a la función que muestra el error en cuanto a la petición de ayuda 
      error_ayuda
    fi

  # En el caso de que los argumentos pasados coincidan con la cantidad de argumentos necesarios, procederá con la ejecución
  elif (( ${#} == 3 )); then
    # Función que revisa los argumentos pasados y llama al resto de funciones
    check_args

  else
    # En caso de no pasar ningún argumento, mostrará la ayuda y saldrá con un código erróneo
    no_arg
  fi
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir con el nombre del script,
# se procederá a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi