#!/bin/bash


#------------------------------------------------------------------------------------------
# Declaración de variables
OPCN_USUARIO=1


#------------------------------------------------------------------------------------------
# Definición de funciones

# Limpieza de pantalla
function limpiar_pantalla(){
    clear
}

# Mostrar menú con las opciones disponibles
function mostrar_menu() {
    echo "Opciones:"
        echo "1.- Crear usuario"
        echo "2.- Habilitar usuario"
        echo "3.- Deshabilitar usuario"
        echo "4.- Cambiar permisos a un usuario"
        echo "5.- Copia de seguridad del directorio de trabajo de un usuario determinado"
        echo "6.- Usuarios conectados actualmente"
        echo "7.- Espacio libre en disco"
        echo "8.- Trazar ruta"
        echo "9.- Salir"
}


# Crear usuario
function crear_usuario(){
    read -p "Introduzca el nombre del usuario que quiere crear " NOMBRE_USUARIO
    echo ""
    read -n 1 -p "¿Quiere crear el usuario con directorio personal? (s/n) " TIPO_CREACION
    echo ""

    if [ $TIPO_CREACION -eq "s" ]; then
        adduser $NOMBRE_USUARIO

    else
        useradd $NOMBRE_USUARIO
        echo "Introduzca la contraseña para el usuario"
        passwd $NOMBRE_USUARIO
    fi

    tail -n -1 /etc/passwd
}


# Habilitar usuarios que anteriormente están deshabilitados
function habilitar_usuarios(){

}


#------------------------------------------------------------------------------------------
# Ejecución del script

while [ $OPCN_USUARIO -ne 9 ]; do
    limpiar_pantalla
    
    mostrar_menu

    read -n 1 -p "Seleccione una opción: " OPCN_USUARIO
    echo ""
    echo $OPCN_USUARIO

    read -n 1 -p "Pulse una tecla para continuar..."
done