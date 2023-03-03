#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Se convierte el primer argumento a "global" y se cambia el nombre
export FIRST_ARG=${1}

# Se convierte el segundo argumento a "global" y se cambia el nombre
export SECOND_ARG=${2}

# Inicialización de variable contadora a 0 para mostrar 
CONTADOR=0

# Inicialización de variable sumatoria de la cantidad de scripts que tienen los usuarios en sus directorios
SUMA_TOTAL=0


#-------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para cuando se pase un único argumento
function un_argumento() {
  if [[ ${FIRST_ARG} == "-h" || ${FIRST_ARG} == "--help" ]]; then
    # Llamada a la función ayuda
    ayuda

  else
    # Se obtienen en "array" los usuarios que hay en el sistema
    USUARIOS_SISTEMA=$( cat /etc/passwd | awk -F ":" '($3 >= 1000 && $3 < 65534) {print $1}' )

    # Se recorren los usuarios guardados
    for USUARIO in ${USUARIOS_SISTEMA}
    do
      echo -e "\e[38;5;123mContando los scripts que tiene el usuario \e[1m${USUARIO}\e[0m \e[38;5;123men su directorio...\e[0m" && echo ""
      
      # Se obtiene el directorio personal del usuario que está en el bucle
      DIRECTORIO_USUARIO=$( cat /etc/passwd | grep ${USUARIO} | awk -F ":" '{print $6}' )
      
      # Se cuenta la cantidad de ficheros *.sh que tiene el usuario en su directorio
      CANTIDAD_SCRIPTS=$( find ${DIRECTORIO_USUARIO} -type f -name "*.sh" | wc -l )
      
      # Se manda un mensaje con la cantidad de scripts que tiene el usuario en la anterior variable al fichero de salida
      echo -e "\e[38;5;27m($(date "+%F %H:%M")) La cantidad de scripts que tiene el usuario \e[1m${USUARIO}\e[0m \e[38;5;27mson: \e[1;38;5;220m${CANTIDAD_SCRIPTS}\e[0m" >> ${FIRST_ARG}

      # Variable contadora para mostrar únicamente la cantidad de líneas añadidas al fichero mediante el bucle
      CONTADOR=$(($CONTADOR + 1))

      # Conteo del total de los scripts que tienen los usuarios
      SUMA_TOTAL=$(($SUMA_TOTAL + $CANTIDAD_SCRIPTS))
    done

    echo -e "\e[38;5;27m($(date "+%F %H:%M")) La cantidad de scripts totales de los usuarios son: \e[1;38;5;220m${SUMA_TOTAL}\e[0m\n" >> ${FIRST_ARG}
    # Se muestra un mensaje de finalización
    echo -e "\e[38;5;46m($(date "+%F %H:%M")) Se ha terminado de contar los scripts de los usuarios\e[0m" && echo ""
    
    # Se muestra el nuevo contenido que se ha pasado al fichero de salida
    tail -n $((${CONTADOR} + 2)) ${FIRST_ARG}
  fi
}


# Función para cuando se pasen dos argumentos
function dos_argumentos() {
  # Comprobación de la existencia del usuario pasado por argumento
  if id ${FIRST_ARG} > /dev/null 2>&1; then
    echo -e "\e[38;5;123mContando los scripts que tiene el usuario ${FIRST_ARG} en su directorio...\e[0m" && echo ""

    # Obtención de la ruta del directorio personal del usuario pasado por argumento
    USER_FOLDER=$( cat /etc/passwd | grep ${FIRST_ARG} | awk -F ":" '{print $6}' )

    # Obtención de la cantidad de scripts que tiene el usuario en su directorio personal
    CANTIDAD_SCRIPTS=$( find ${USER_FOLDER} -type f -name "*.sh" | wc -l )

    # Se muestran la cantidad de scripts que tiene el usuario en la anterior variable
    echo -e "\e[38;5;27m($(date "+%F %H:%M")) La cantidad de scripts que tiene el usuario \e[1m${FIRST_ARG}\e[0m \e[38;5;27mson: \e[1;38;5;220m${CANTIDAD_SCRIPTS}\e[0m\n" >> ${SECOND_ARG}

    echo -e "\e[38;5;46mSe ha terminado de contar los scripts del usuario \e[1m${FIRST_ARG}\e[0m" && echo ""

    # Mostrado de la última línea del fichero al que se pasan los datos
    tail -n 2 ${SECOND_ARG}
  else
    echo -e "\e[38;5;196mEl usuario \e[1m${FIRST_ARG}\e[0m \e[38;5;196mno existe en el sistema\e[0m"
    exit 1
  fi
}


function main() {
  # Importación del script que contiene la función de ayuda
  source modules/help.sh

  if (( ${#} == 1 )); then
    # Llamada a la función para todos los usuarios y el fichero de salida
    un_argumento

  elif (( ${#} == 2 )); then
    # Llamada a la función para el usuario y el fichero de salida
    dos_argumentos

   else
    # Llamada a la función ayuda
    ayuda

    # Se sale con código de error erróneo al no especificar argumentos
    exit 1
  fi
}


#-------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi
