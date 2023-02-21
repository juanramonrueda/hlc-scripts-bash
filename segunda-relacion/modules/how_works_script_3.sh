#!/bin/bash


#------------------------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Función para mostrar la ayuda sobre el script
function main() {
  echo -e "\e[38;5;160mNo ha introducido los argumentos correctamente para el script" && echo ""
  echo "Las operaciones son: suma (+); resta (-); multiplicación (*), división y obtención del cociente (/); división y obtención del resto (%)" && echo ""
  echo "Siga la sintáxis de los siguientes ejemplos para hacer uso del script:"
  echo -e "\e[1m${0} 5 6 +\e[0m" && echo ""
  echo -e "\e[38;5;160mPara la multiplicación debe usar el backslash (\) de la siguiente forma:"
  echo -e "\e[1m${0} 6 5 \*\e[0m"
  exit 1
}


#------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

main