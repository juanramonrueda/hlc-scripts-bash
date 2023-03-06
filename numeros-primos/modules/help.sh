#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para explicar el uso del script
function ayuda() {
  echo -e "\e[38;5;162mEste script muestra los números primos comprendidos entre dos números pasados por argumentos"
  echo -e "Los números que se han de pasar son \e[1;38;5;226mpositivos enteros\e[0m"
  echo -e "\e[38;5;129m${0} 1 30"
  echo -e "${0} 50 10\e[0m"
}


# Función para indicar que hay un error en la petición de ayuda del script
function error_ayuda() {
  # Se muestra un error y se sale con el código de error
  echo -e "\e[38;5;196mSe ha equivocado con el argumento para la petición de ayuda, use:"
  echo -e "\e[1m${0} -h"
  echo -e "${0} --help\e[0m"
  exit 1
}


# Función para indicar que no se hay pasado los argumentos requeridos al script
function no_args() {
  echo -e "\e[38;5;196mPara hacer uso de este script debe pasar dos argumentos, \e[38;5;21mambos números enteros positivos\e[0m"
  echo -e "\e[38;5;129m${0} 1 30"
  echo -e "${0} 50 10\e[0m"
}


# Función para indicar que los argumentos introducidos no son números o no son válidos
function no_numbers() {
  echo -e "\e[38;5;196mLos números que ha de pasar son \e[38;5;21menteros positivos\e[0m"
  echo -e "\e[38;5;129m${0} 1 30"
  echo -e "${0} 50 10\e[0m"
}