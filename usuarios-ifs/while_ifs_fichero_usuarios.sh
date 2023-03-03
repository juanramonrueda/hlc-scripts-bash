#!/bin/bash


#-------------------------------------------------------------------------------------------------------
# Declaración de variables

# Declaración de variable para agregar una cabecera al fichero de salida
CABECERA_SALIDA="NOMBRE APELLIDO;NOM_USUARIO"

# Asignación del primer argumento recibido a una variable
INPUT_FILE="${1}"

# Obtención de la ruta del directorio del usuario
RUTA_DIRECTORIO_USUARIO=$( eval echo "~${USUARIO}" )

# Declaración de la ruta del directorio personal del usuario y archivo intermedio
INTERMEDIATE_FILE="${RUTA_DIRECTORIO_USUARIO}/intermedio.txt"

# Asignación del segundo argumento recibido a una variable
OUTPUT_FILE="${2}"


#-------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para comprobar el contenido del archivo de salida y realizar el traspaso de información
# del archivo de entrada al fichero de salida sin sobreescribir y sin duplicar, triplicar...
function generate_output_file_content() {
  # Uso de un archivo intermedio para omitir la cabecera
  tail -n +2 ${INPUT_FILE} >> ${INTERMEDIATE_FILE}

  # Con read -r se lee línea a línea el archivo de entrada y se guarda en REGISTROS_FICHERO
  while IFS= read -r REGISTROS_FICHERO
  do
    # Se realizan operaciones con las cadenas para el formateo del archivo de salida

    # Obtención del nombre que hay en el registro
    NOMBRE_REGISTRO=$( echo "${REGISTROS_FICHERO}" |  cut -d ';' -f 1 )

    # Obtención del apellido que hay en el registro
    APELLIDO_REGISTRO=$( echo "${REGISTROS_FICHERO}" | cut -d ';' -f 2 )

    # Obtención del DNI que hay en el registro
    DNI_REGISTRO=$( echo "${REGISTROS_FICHERO}" | cut -d ';' -f 3 )

    # Obtención de la primera letra del nombre en minúsculas para el nombre de usuario
    LETRA_NOMBRE_REGISTRO=$( echo "${NOMBRE_REGISTRO}" | tr [A-Z] [a-z] | cut -c 1 )

    # Obtención de las tres primeras letras del apellido en minúsculas para el nombre de usuario
    LETRAS_APELLIDO_REGISTRO=$( echo "${APELLIDO_REGISTRO}" | tr [A-Z] [a-z] | cut -c 1,2,3 )

    # Obtención de los dos últimos caracteres del DNI para el nombre de usuario, como no se
    # puede hacer "cut -c -1,-2", hay que "dar la vuelta" a los caracteres del DNI, obtener
    # las dos primeras posiciones y volver a dar la vuelta para ordenar los dos caracteres
    CARACTERES_DNI=$( echo "${DNI_REGISTRO}" | rev | cut -c 1,2 | rev )

    # Obtención del nombre de usuario concatenando las variables usadas para tal fin
    NOMBRE_USUARIO="${LETRA_NOMBRE_REGISTRO}${LETRAS_APELLIDO_REGISTRO}${CARACTERES_DNI}"

    # Obtención del registro que hay que pasar al fichero de salida
    REGISTRO_FINAL_ENTRADA="${NOMBRE_REGISTRO} ${APELLIDO_REGISTRO};${NOMBRE_USUARIO}"

    REGISTROS_SALIDA=$( cat ${OUTPUT_FILE} | grep "${OUTPUT_REGISTRO_FINAL_ENTRADAFILE}" )

    # Comprobación de que el registro que se ha obtenido no está en el fichero de salida
    if [[ "${OUTPUT_REGISTRO_FINAL_ENTRADAFILE}" != "${REGISTROS_SALIDA}" ]]; then
      echo "Introduciendo ${OUTPUT_REGISTRO_FINAL_ENTRADAFILE} al fichero de salida..."
      echo ${OUTPUT_REGISTRO_FINAL_ENTRADAFILE} >> ${OUTPUT_FILE}

    # En el caso de que el registro esté repetido, no se volverá a introducir
    else
      echo "El registro ${OUTPUT_REGISTRO_FINAL_ENTRADAFILE} está repetido y no se introducirá"
    fi

  # Con done < ${INTERMEDIATE_FILE} se lee el archivo intermedio para el bucle
  done < ${INTERMEDIATE_FILE}

  # Borrado del archivo intermedio
  rm ${INTERMEDIATE_FILE}

  # Pequeña parada de dos segundos
  sleep 2s

  # Mensaje de finalización
  echo "Finalización de la ejecución"
}


# Función principal
function main() {
  # Importación del módulo para la ayuda del script
  source modules/help.sh
  
  # Comprobación de la cantidad de argumentos pasados al script
  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del script help.sh
      ayuda
    
    else
      # Llamada a la función que muestra el error en cuanto a la petición de ayuda
      error_ayuda
    fi

  elif (( ${#} == 2 )); then

    # Comprobación de que el fichero de entrada existe
    if test -e ${INPUT_FILE}; then

      # Comprobación de que el fichero de salida existe
      if test -e ${OUTPUT_FILE}; then
        # Llamada a la función que generará el contenido al fichero de salida
        generate_output_file_content

      # Creación del fichero de salida junto a la cabecera en el caso de no existir
      else
        # Mensaje de que se está creando el fichero de salida
        echo "Creando el fichero ${OUTPUT_FILE}..."

        # Pequeña parada de un segundo
        sleep 1s

        # Creación del archivo y agregación de la cabecera al fichero
        touch ${OUTPUT_FILE} && echo "${CABECERA_SALIDA}" >> ${OUTPUT_FILE}

        # Llamada a la función que generará el contenido al fichero de salida
        generate_output_file_content
      fi

    # En el caso de que el fichero de entrada no exista, saldrá de la ejecución del script
    else
      echo "El fichero de entrada ${INPUT_FILE} no existe"
      exit 1
    fi

  # En el caso de que se hayan pasado una cantidad distinta a dos argumentos, mostrará los mensajes
  else
    # Muestra la cantidad de argumentos que se han pasado al script
    echo -e "\e[38;5;196mHa introducido una cantidad incorrecta de argumentos al script" && echo ""
    ayuda
    exit 1
  fi
}


#-------------------------------------------------------------------------------------------------------
# Ejecución del script

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir
# con el nombre del script, se procederá a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi