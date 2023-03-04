#!/bin/bash


#------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para obtener el usuario activo en el sistema
function active_user() {
  echo -e "\e[34mUsuario activo en el sistema:"
  echo -e "\e[1m${USER}" && echo -e "\e[0m"
}


# Función para obtener el directorio del usuario activo del sistema
function working_directory() {
  echo -e "\e[38;5;198mDirectorio de trabajo del usuario activo en el sistema:\e[1m"
  grep ${USER} /etc/passwd | awk -F ":" '{print $6}' && echo -e "\e[0m"
}


# Función para obtener el Shell asociado al usuario activo del sistema
function user_shell() {
  echo -e "\e[38;5;208mShell asociada al usuario activo en el sistema:\e[1m"
  echo -e "${SHELL}\e[0m"
}


# Función principal
function main() {
  # Importación de módulos necesarios para la ejecución del script
  source modules/script_8/help.sh

  if (( ${#} == 0 )); then
    # Llamada a la función que muestra el usuario activo en el sistema
    active_user

    # Llamada a la función que muestra el directorio de trabajo del usuario activo en el sistema
    working_directory

    # Llamada a la función que muestra el Shell asociado al usuario activo en el sistema
    user_shell
  
  elif (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función ayuda
      ayuda
    
    else
      # Llamada a la función para mostrar un error en la petición de la ayuda
      error_ayuda
    fi
  
  else
    # Llamada a la función que indica que el script no necesita argumentos para su ejecución
    no_args
  fi
}


#------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi