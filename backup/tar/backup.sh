#!/bin/bash


#-----------------------------------------------------------------------------------------------------------
# Declaración de variables

# Variable para establecer el directorio en el que se monta el dispositivo externo
BACKUP_DIR_NAME="/backup"

# Variable para establecer el nombre para las copias de seguridad
BACKUP_FILE_NAME="BK-$(date +%Y%m%d).tar"

# Variable para establecer el directorio para los archivos log
LOGS_DIR_NAME="/logs/backup"

# Variable para establecer el nombre del archivo log con el año, mes y día de creación
LOG_FILE_NAME="BK_log-$(date +%Y%m%d).log"

# Variable para concatenar el directorio para los logs y el archivo log
GENERATE_LOGS="${LOGS_DIR_NAME}/${LOG_FILE_NAME}"


#-----------------------------------------------------------------------------------------------------------
# Declaración de función

# Declaración de la función principal
function main() {
  # Llamada a la función que realiza la limpieza de pantalla
  source ../../modules/clear_screen.sh

  # Comprobación de la existencia del directorio para los archivos logs
  if [[ ! -d ${LOGS_DIR_NAME} ]]; then
    mkdir -p ${LOGS_DIR_NAME}
  fi

  # Generación del contenido del archivo log
  exec &>>${GENERATE_LOGS}

  # Guardado en lista de los usuarios del sistema que tienen el UID 1000 o superior
  SYSTEM_USERS_LIST=$( cat /etc/passwd | awk -F ":" '($3 >= 1000) {print $1}' )

  # Deshabilitación de los usuarios que están en la lista
  for SYSTEM_USER in ${SYSTEM_USERS_LIST}
  do
    usermod -L ${SYSTEM_USER}
  done

  # Guardado en variable del estado del runlevel
  ACTUAL_RUNLEVEL=$( who -r | awk -F " " '{print $2}' )

  # Si el runlevel es distinto de 1, se fuerza la entrada al runlevel 1
  if [[ ${ACTUAL_RUNLEVEL} != "1" ]]; then
    init 1
  fi

  # Guardado en variable mediante lista de los directorios sobre los que hay que hacer copia de seguridad
  COPY_DIR=$( ls /home )

  # Realización de la copia de seguridad
  tar -cvf $BACKUP_DIR_NAME/$BACKUP_FILE_NAME $COPY_DIR

  
  # Habilitación de los usuarios del sistema que se encuentran en la lista del principio
  for SYSTEM_USER in ${SYSTEM_USERS_LIST}
  do
    usermod -U ${SYSTEM_USER}
  done

  # Reinicio del sistema
  reboot -f
}


#-----------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi