#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variable

# Se pasa el primer argumento a variable
export RUTA_FICHERO="${1}"

# Se inicializa la variable a 1 para el comando cut -f y se hace "global"
export LISTADO_NIVELES=1


#------------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función que explica el funcionamiento del script
function ayuda(){
  echo -e "\e[38;5;27mEste script lee los ficheros y muestra su contenido, la cantidad de líneas, palabras y letras que tiene\e[0m"
}

# Función que muestra un mensaje en el caso de no existir el fichero en la ruta
function file_doesnt_exists() {
  # Se obtienen los niveles de la ruta dada por el usuario mediante argumento
  CANTIDAD_NIVELES_FICHERO=$( echo "${RUTA_FICHERO}" | grep -o "/" | wc -l )

  # Se recorren los niveles para realizar un cut -f y obtener la ruta en la que se encuentra el archivo
  for NIVELES in $(seq 1 ${CANTIDAD_NIVELES_FICHERO})
  do
      # Variable para usar junto al modificador -f del comando cut y obtener los campos necearios
      LISTADO_NIVELES="${LISTADO_NIVELES},${NIVELES}"
  done

  # Se obtiene en variable la ruta del archivo, sin agregar a la variable el archivo
  RUTA_FICHERO=$( echo "${RUTA_FICHERO}" | cut -d "/" -f ${LISTADO_NIVELES} )

  # Se usa echo -e para referenciar el backslash "\" como carácter normal y \e[0m y finalizar el cambio de color
  echo -e "Estos son los ficheros que se encuentran en la ruta ${RUTA_FICHERO}:\e[0m" && echo ""
  
  # Se usa pasa find mediante pipeline para encontrar los ficheros del directorio sin subdirectorios
  ls | find ${RUTA_FICHERO} -type f -maxdepth 1
}


# Función principal
function main() {
  # Llamada al script de limpieza de pantalla
  source clear_screen.sh

  # Comprobación de la cantidad de argumentos pasados
  if (( $# != 1 )); then
    # Llamada a la función que explica qué hace el script
    ayuda

    # Llamada al script que explica cómo funciona el script
    source how_works_script_1.sh

  # Entrada a esta condición cuando el número de argumentos sea 1
  else
    # Comprobación de la no existencia del fichero
    if ! test -f ${RUTA_FICHERO} ; then
      echo -e "\e[91mEl fichero no existe" && echo "" && file_doesnt_exists

    # Entrada a esta condición debido a la existencia del fichero en la ruta
    else
      # Obtención del nombre del archivo en variable
      NOMBRE_FICHERO=$( echo "${RUTA_FICHERO}" | rev | cut -d "/" -f 1 | rev )
    
      echo "El fichero ${NOMBRE_FICHERO} existe" && echo ""
    
      # Se usa el modificador -e para coger el backslash "\" como caracter normal y se añade un código de color, \e[94m
      echo -e "\e[1;94mContenido del archivo con líneas numeradas\e[0;94m:"
    
      # Se muestra el contenido del fichero con las líneas numeradas y se pone el color por defecto mediante \e[0m
      awk '{print NR, $0 }' ${RUTA_FICHERO} && echo -e "\e[0m"

      # Se obtienen la cantidad total de líneas en variable
      CANTIDAD_LINEAS_FICHERO=$( wc -l < ${RUTA_FICHERO} )
      echo -e "\e[1;92mEl fichero tiene ${CANTIDAD_LINEAS_FICHERO} líneas en total\e[0m" && echo ""
      
      # Se obtienen la cantidad de palabras que tiene el fichero
      CANTIDAD_PALABRAS_FICHERO=$( wc -w < ${RUTA_FICHERO} )
      echo -e "\e[1;95mEl fichero tiene ${CANTIDAD_PALABRAS_FICHERO} palabras en total\e[0m" && echo ""

      # Se obtienen la cantidad de caracteres que tiene el fichero
      CANTIDAD_CARACTERES_FICHERO=$( wc -m < ${RUTA_FICHERO} )
      echo -e "\e[1;33mEl fichero tiene ${CANTIDAD_CARACTERES_FICHERO} caracteres en total\e[0m"
    fi
  fi
}


#------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi