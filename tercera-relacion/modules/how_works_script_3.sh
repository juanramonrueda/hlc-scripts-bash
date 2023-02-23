#!/bin/bash


#----------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para indicar el funcionamiento del script para únicamente tres argumentos
function main() {
  # Se pone el texto en bold (negrita) mediante \e[1 y se concatena con semicolor a 35m para el color rojo
  echo -e "\e[1;31mArgumentos incorrectos"
  echo "Para hacer uso del script, debe pasar tres ficheros (el tercero no importa si existe) como:" && echo ""
  echo "$0 fichero_1.txt fichero_2.txt fichero_3.txt" && echo ""
  echo "$0 /home/usuario/fichero_1.txt /home/usuario/Documentos/fichero_2.txt ./fichero_3.txt"

  # Código de salida erróneo
  exit 1
}


#----------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal para la llamada desde otro script

main