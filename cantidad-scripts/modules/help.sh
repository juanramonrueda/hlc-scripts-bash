#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------

# Función para mostrar la ayuda del funcionamiento del script
function main() {
  echo -e "\e[38;5;162mEste script tiene la función de contar los scripts que tienen los usuarios\e[0m" && echo ""
  echo -e "\e[38;5;129m${0} [usuario] <fichero_salida>\e[0m" && echo ""
  echo -e "\e[38;5;162mPara usarlo, puede pasar opcionalmente un usuario (sin []) y obligatoriamente un fichero de salida (sin <>)"
  echo "En el caso de que no pase un usuario, contará los scripts de cada usuario y el total de los mismos"
  echo -e "En el caso de que pase un usuario, contará únicamente los scripts de ese usuario\e[0m"

  # No se indica salida con código de error para que salga siempre 0 en el caso de consultar la ayuda 
}


#------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal de ayuda

main