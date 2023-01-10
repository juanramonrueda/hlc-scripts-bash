#!/bin/bash


#-----------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Variable para entrar en el bucle sin tener que preguntar fuera del mismo
OPCN_USUARIO=1


#-----------------------------------------------------------------------------------------------------------------
# Definición de funciones

# Limpieza de pantalla
function limpiar_pantalla(){
    clear
}

# Se muestra el menú con las opciones disponibles
function mostrar_menu() {
    echo "Opciones:"

    # Se tabulan para el formateo de salida
    echo "      1.- Crear usuario"
    echo "      2.- Habilitar usuario"
    echo "      3.- Deshabilitar usuario"
    echo "      4.- Cambiar permisos a un usuario"
    echo "      5.- Copia de seguridad del directorio de trabajo de un usuario determinado"
    echo "      6.- Usuarios conectados actualmente"
    echo "      7.- Espacio libre en disco"
    echo "      8.- Trazar ruta"
    echo "      9.- Salir"
}


# Creación de usuario
function crear_usuario(){
    # Petición del nombre de usuario que hay que crear
    read -p "Introduzca el nombre del usuario que quiere crear: " NOMBRE_USUARIO
    
    # Salida vistosa y que no quede todo compactado
    echo ""
    
    # Se usa -n 1 para no tener que pulsar la tecla Intro y continuar en cuanto se introduzca un carácter
    read -n 1 -p "¿Quiere crear el usuario con directorio personal? (S/N): " TIPO_CREACION_SIN_VALIDAR
    echo ""

    # Se convierte el contenido de la variable de mayúscula a minúscula
    TIPO_CREACION=$( echo "$TIPO_CREACION_SIN_VALIDAR" | tr [A-Z] [a-z] )

    # Comprobación si el usuario tendrá o no directorio personal
    if [[ $TIPO_CREACION == "s" ]]; then
        # ADDUSER crea el usuario con la contraseña que tendrá y además crea el directorio personal
        adduser $NOMBRE_USUARIO

    else
        # USERADD crea directamente el usuario sin directorio personal y sin contraseña
        useradd $NOMBRE_USUARIO

        # Se indica que se introduzca una contraseña para el usuario creado
        echo "Introduzca la contraseña para el usuario"
        
        # Se ejecuta el comando para asignar una contraseña al usuario creado
        passwd $NOMBRE_USUARIO

    fi

    # Se muestra el último registro para mostrar el usuario creado
    tail -n -1 /etc/passwd
}


# Habilitación de usuarios que se encuentran deshabilitados
function habilitar_usuarios(){
    read -p "Introduzca el usuario que quiere habilitar: " NOMBRE_USUARIO

    # Se guarda en variable el primer carácter de la contraseña cifrada para saber el estado del usuario
    COMPROBACION_DESHABILITACION=$( cat /etc/shadow | grep $NOMBRE_USUARIO | cut -d ":" -f 2 | cut -c 1 )

    # Comprobación del carácter guardado en la anterior variable, en el caso de que sea "!", está deshabilitado 
    if [[ $COMPROBACION_DESHABILITACION != "!" ]]; then
        echo "El usuario se encuentra habilitado, por lo que no se realizará ninguna operación"
    
    # En el caso de que empiece por "!", se habilitará el usuario
    else
        usermod -U $NOMBRE_USUARIO

        echo "El usuario se ha habilitado"
    fi
}


# Deshabilitación de usuarios
function deshabilitar_usuarios() {
    read -p "Introduzca el usuario que quiere deshabilitar: " NOMBRE_USUARIO

    usermod -L $NOMBRE_USUARIO
}


#-----------------------------------------------------------------------------------------------------------------
# Ejecución del script

while [[ $OPCN_USUARIO == "9" ]]; do
    limpiar_pantalla
    
    mostrar_menu
    
    echo ""
    read -n 1 -p "Seleccione una opción: " OPCN_USUARIO
    echo ""

    case $OPCN_USUARIO in
        1) crear_usuario;;
        2) habilitar_usuarios;;
        3) deshabilitar_usuarios;;
        4);;
        5);;
        6);;
        7);;
        8);;
        9) echo "Ejecución finalizada";;
        *) echo "Se ha equivocado de número"
    esac

    if [[ $OPCN_USUARIO == "9" ]]; then
        read -n 1 -p "Pulse una tecla para continuar..."
    
    fi
done