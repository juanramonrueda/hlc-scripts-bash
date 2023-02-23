#!/bin/bash


#----------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para indicar el funcionamiento del script para un único argumento
function main() {
  # Se pone el texto en bold (negrita) mediante \e[1 y se concatena con semicolor a 35m para el color rojo
  echo -e "\e[1;31mArgumentos incorrectos"
  echo "Para hacer uso del script, debe pasar un único fichero como:" && echo ""
  
  # Se usa $0 para indicar el script que ha ejecutado este script
  echo "$0 prueba.txt" && echo ""
  echo -e "$0 /home/usuario/prueba.txt\e[0m"

  # Código de salida erróneo
  exit 1
}


#----------------------------------------------------------------------------------------------------------
# Ejecución de la función principal para la llamada desde otro script

main