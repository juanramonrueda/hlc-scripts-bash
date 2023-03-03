#!/bin/bash


#--------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Declaración de la variable a string para entrar en el bucle de la función principal
OPCN_USUARIO=1

# Variable contadora para mostrar la primera vez el avido de sudo
CONTADOR=0


#--------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para dar permisos de ejecución a un directorio
function dar_ejecucion_archivos() {
  # Petición de un directorio al que dar los permisos de ejecución a los archivos que contiene
  read -p "Introduzca un directorio al que asignar los permisos de ejecución a los archivos que contiene: " DIRECTORIO
  
  # Comprobación de que el directorio existe
  if test -d ${DIRECTORIO}; then
    # En el caso de que el directorio exista, se usará el comando find en la ruta del directorio para filtrar
    # por todos los archivos que sean ficheros (-type f) y mediante pipeline, se pasa la búsqueda de los ficheros
    # al comando chmod haciendo uso de xargs que son todos los ficheros que ha encontrado el comando find para
    # dar los permisos de ejecución de Usuario y Grupo a los ficheros
    find ${DIRECTORIO} -type f | xargs chmod u+x,g+x

    # Se muestra el mensaje de finalización
    echo "Se han realizado los cambios" && echo ""

  # En el caso de que no exista el directorio, mostrará el mensaje
  else
    echo "El directorio ${DIRECTORIO} no existe"
  fi
}


# Función para quitar permisos de ejecución a un directorio
function quitar_ejecucion_archivos() {
  # Petición de un directorio al que quitar los permisos de ejecución a los archivos que contiene
  read -p "Introduzca un directorio al que quitar los permisos de ejecución a los archivos que contiene: " DIRECTORIO

  # Comprobación de que el directorio existe
  if test -d ${DIRECTORIO}; then
    # En el caso de que el directorio exista, se usará el comando find en la ruta del directorio para filtrar
    # por todos los archivos que sean ficheros (-type f) y mediante pipeline, se pasa la búsqueda de los ficheros
    # al comando chmod haciendo uso de xargs que son todos los ficheros que ha encontrado el comando find para
    # quitar los permisos de ejecución de Usuario y Grupo a los ficheros
    find ${DIRECTORIO} -type f | xargs chmod u-x,g-x

    # Se muestra el mensaje de finalización
    echo "Se han realizado los cambios" && echo ""

  # En el caso de que no exista el directorio, mostrará el mensaje
  else
      echo "El directorio ${DIRECTORIO} no existe"
  fi
}


# Función para realizar copia de seguridad del directorio personal del usuario con comprobación del usuario
function copia_seguridad_usuario(){
  DIRECTORIO_COPIAS_SEGURIDAD="/copias_seguridad_usuarios"

  # Petición del nombre de usuario para realizar la copia de seguridad de su directorio personal
  echo "" && read -p "Introduzca el nombre del usuario del cuál quiere hacer una copia de seguridad de su directorio personal: " USUARIO

  # Se comprueba si el usuario especificado existe en el sistema, redirigiendo la salida normal (1) y de error (2) a null
  # Con id "${USUARIO}" se muestra información sobre el usuario y en caso de existir, entra en el IF
  if id "${USUARIO}" >/dev/null 2>&1; then

    # Comprobación de la existencia del directorio que contendrá las copias de seguridad
    # En este caso comprueba de que no existe mediante "!" y -d para directorios
    if [[ ! -d ${DIRECTORIO_COPIAS_SEGURIDAD} ]]; then
      # Creación del directorio que contendrá las copias de seguridad
      mkdir -p ${DIRECTORIO_COPIAS_SEGURIDAD}

      # Se muestra la creación del directorio que contendrá las copias de seguridad
      echo "" && echo "Se ha creado el directorio ${DIRECTORIO_COPIAS_SEGURIDAD}"
    fi

    # Se obtiene la ruta del directorio personal del usuario mediante echo "~${USUARIO}"
    # El comando "eval" se usa para evaluar la expresión siguiente al comando y obtener la ruta
    RUTA_DIRECTORIO_USUARIO=$( eval echo "~${USUARIO}" )

    # Se guarda en variable el nombre que tendrá el archivo comprimido del directorio personal del usuario con el nombre, fecha y hora 
    NOMBRE_BACKUP="${USUARIO}-home_$(date +%Y%m%d_%H%M%S).tar.gz"

    # Se realiza la compresión del contenido del directorio personal del usuario
    tar -czvf ${DIRECTORIO_COPIAS_SEGURIDAD}/${NOMBRE_BACKUP} ${RUTA_DIRECTORIO_USUARIO}

    # Se muestra un mensaje y el contenido del directorio que contiene las copias de seguridad
    echo "" && echo "Archivos del directorio ${DIRECTORIO_COPIAS_SEGURIDAD}:"

    echo "" && ls ${DIRECTORIO_COPIAS_SEGURIDAD}

  # En caso de no existir el usuario en el sistema, avisa al usuario
  else
    echo "" && echo "El usuario ${USUARIO} no existe en el sistema"
  fi
}


# Función para registrar los veinte inicios de sesión más recientes en un archivo log
function log_inicios_sesion() {
  # Declaración de directorio para los archivos log
  DIRECTORIO_LOGS="/archivos_logs"
  NOMBRE_ARCHIVO_LOG="ultimos20.log"

  # Comprobación de que el directorio para los archivos log existe, en este caso que no exista
  if [[ ! -d ${DIRECTORIO_LOGS} ]]; then
    # Creación del directorio para el archivo de log de los últimos veinte inicios de sesiones
    mkdir -p ${DIRECTORIO_LOGS}

    # Ejecución del comando last para conocer los inicios de sesión, después se pasa mediante pipeline
    # a grep para ignorar (modificador -i) inversamente (modificador -v) de los inicios de reboot que
    # puedan haber mediante el uso del comando last, después el resultado se pasa a head para obtener
    # los primeros (modificador -n) veinte registros y por último con tee -a se añade a un archivo
    # y sale por pantalla el resultado
    last --fullnames | grep -i -v reboot | head -n 20 | tee -a ${DIRECTORIO_LOGS}/${NOMBRE_ARCHIVO_LOG}

  # En el caso de que exista el directorio, realiza directamente el uso del comando
  else
    last --fullnames | grep -i -v reboot | head -n 20 | tee -a ${DIRECTORIO}_LOGS/${NOMBRE_ARCHIVO_LOG}
  fi
}


# Función principal
function main() {
  # Importación de los scripts para el funcionamiento de este script
  source modules/script_2/clear_screen.sh
  source modules/script_2/help.sh
  source modules/script_2/menu.sh

  # Comprobación de si hay argumento
  if (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del script help.sh
      ayuda
    else
      # Se muestra un error y se sale con el código de error
      echo -e "\e[1;38;5;196mSe ha equivocado de argumento, es ${0} -h ó ${0} --help\e[0m"
      exit 1
    fi
  fi

  while (( ${OPCN_USUARIO} != 0 )); do
    # Llamada a la función para limpiar la pantalla
    clear_screen

    if (( ${CONTADOR} <= 0 )); then
      # Llamada a la función que avisa del uso de sudo al usuario del script menu.sh
      aviso_sudo
    fi

    # Llamada a la función para mostrar el menú de opciones
    menu_opciones

    # Petición y registro de una opción pedida al usuario
    read -n 1 -p "Introduzca la opción que quiera usar: " OPCN_USUARIO && echo ""

    # Comparación de la opción dada por el usuario
    case ${OPCN_USUARIO} in
      1) dar_ejecucion_archivos;;
      2) quitar_ejecucion_archivos;;
      3) copia_seguridad_usuario;;
      4) log_inicios_sesion;;
      0) echo "Ejecución finalizada";;
      *) echo "Se ha equivocado de número";;
    esac

    # En el caso de que la opción del usuario sea distinta de "0", realizará una pequeña pausa
    # y pedirá una pulsación de tecla
    if (( ${OPCN_USUARIO} != 0 )); then
      sleep 1s

      echo ""
      read -n 1 -p "Pulse una tecla para continuar..."
    fi

    CONTADOR=$(( ${CONTADOR} + 1 ))
  done
}

#--------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir
# con el nombre del script, se procederá a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi