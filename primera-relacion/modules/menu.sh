#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------------------
# Declaración de función

# Se muestra el menú con las opciones disponibles
function opciones_disponibles() {
  echo -e "\e[38;5;119mOpciones:"

  # Se tabulan para el formateo de salida
  echo "      1.- Crear usuario"
  echo "      2.- Habilitar usuario"
  echo "      3.- Deshabilitar usuario"
  echo "      4.- Cambiar permisos a un fichero"
  echo "      5.- Copia de seguridad del directorio de trabajo de un usuario determinado"
  echo "      6.- Usuarios conectados actualmente"
  echo "      7.- Espacio libre en disco"
  echo "      8.- Trazar ruta"
  echo -e "      9.- Salir\e[0m"
}
