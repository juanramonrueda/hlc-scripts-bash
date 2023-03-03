#!/bin/bash


#---------------------------------------------------------------------------------------
# Declaración de función

# Función para mostrar el menú de las opciones disponibles
function menu_opciones() {
  echo -e "\e[38;5;119mOpciones:"
  
  # Se tabulan para el formateo de salida
  echo "      1.- Dar permiso de ejecución a todos los archivos de un directorio"
  echo ""
  echo "      2.- Quitar permiso de ejecución a todos los archivos de un directorio"
  echo ""
  echo "      3.- Hacer copia de seguridad del directorio de trabajo de un usuario"
  echo ""
  echo "      4.- Obtener en un archivo los 20 inicios de sesión más recientes"
  echo ""
  echo -e "      0.- Salir\e[0m"
}