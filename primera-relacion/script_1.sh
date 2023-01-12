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
    read -n 1 -p "¿Quiere crear el usuario con directorio personal? (S/N): " RESPUESTA
    echo ""

    # Comprobación si el usuario tendrá o no directorio personal
    if [[ $RESPUESTA == "s" || $RESPUESTA == "S" ]]; then
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
    echo ""
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


# Cambio de permisos de un fichero para un usuario
function permisos_fichero(){
    read -p "Introduzca la ruta absoluta del fichero al que quiere cambiar los permisos" RUTA_RUTA_NOMBRE_FICHERO

    RUTA_FICHERO=$()

    NOMBRE_FICHERO=$(echo "$RUTA_RUTA_NOMBRE_FICHERO" | cut -d '/' -1)

    if test -e $RUTA_NOMBRE_FICHERO ; then
        echo "Permisos de Usuario: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 2-4)
        echo ""
        echo "Permisos de Grupo: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 5-7)
        echo ""
        echo "Permisos de Otros: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 8-10)
        echo ""
        echo "r => Lectura | w => Escritura | x => Ejecución | - => Sin permiso"
        echo ""
        read -n 1 -p "¿Quiere cambiar los permisos? (S/N): " RESPUESTA
        echo ""

        if [[ $RESPUESTA = "S" || $RESPUESTA = "s" ]] ; then
            echo "Escriba la letra o letras en el orden anterior para asignar los permisos (las letras que no se pongan servirán para quitar el permiso)"
            echo ""

            for GRUPOS in Usuario Grupo Otros ; do
                read -p "Introduzca los permisos de $GRUPOS: " PERMISOS

                PERMISOS_MAY=$(echo $PERMISOS | tr [a-z] [A-Z])
                echo ""

                if [ $GRUPOS = Usuario ] ; then
                    case $PERMISOS_MAY in
                        RWX) chmod u+rwx $RUTA_NOMBRE_FICHERO;;
                        RW) chmod u+rw-x $RUTA_NOMBRE_FICHERO;;
                        RX) chmod u+rx-w $RUTA_NOMBRE_FICHERO;;
                        R) chmod u+r-wx $RUTA_NOMBRE_FICHERO;;
                        WX) chmod u+wx-r $RUTA_NOMBRE_FICHERO;;
                        W) chmod u+w-rx $RUTA_NOMBRE_FICHERO;;
                        X) chmod u+x-rw $RUTA_NOMBRE_FICHERO;;
                    esac

                elif [ $GRUPOS = Grupo ] ; then
                    case $PERMISOS_MAY in
                        RWX) chmod g+rwx $RUTA_NOMBRE_FICHERO;;
                        RW) chmod g+rw-x $RUTA_NOMBRE_FICHERO;;
                        RX) chmod g+rx-w $RUTA_NOMBRE_FICHERO;;
                        R) chmod g+r-wx $RUTA_NOMBRE_FICHERO;;
                        WX) chmod g+wx-r $RUTA_NOMBRE_FICHERO;;
                        W) chmod g+w-rx $RUTA_NOMBRE_FICHERO;;
                        X) chmod g+x-rw $RUTA_NOMBRE_FICHERO;;
                    esac

                else
                    case $PERMISOS_MAY in
                        RWX) chmod o+rwx $RUTA_NOMBRE_FICHERO;;
                        RW) chmod o+rw-x $RUTA_NOMBRE_FICHERO;;
                        RX) chmod o+rx-w $RUTA_NOMBRE_FICHERO;;
                        R) chmod o+r-wx $RUTA_NOMBRE_FICHERO;;
                        WX) chmod o+wx-r $RUTA_NOMBRE_FICHERO;;
                        W) chmod o+w-rx $RUTA_NOMBRE_FICHERO;;
                        X) chmod o+x-rw $RUTA_NOMBRE_FICHERO;;
                    esac
                fi
            done

            echo "Permisos del Usuario: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 2-4)
            echo ""
            echo "Permisos del Grupo: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 5-7)
            echo ""
            echo "Permisos de Otros: "$(ls -ld $RUTA_NOMBRE_FICHERO | cut -c 8-10)
            echo ""

        else
            echo "Los permisos no han sufrido modificación"
        fi
        
    else
        echo "El archivo $NOMBRE_FICHERO existe en la ruta" $RUTA_FICHERO
    fi
}


# Copia de seguridad del directorio personal de un usuario
function copia_seguridad_usuario(){
    echo "hola"
}


# Usuarios conectados en el sistema
function usuarios_conectados_sistema(){
    echo "hola"
}


# Espacio libre en el disco duro
function espacio_libre_disco(){
    echo "hola"
}


# Trazado de ruta desde el origen hasta la IP o URL de destino
function trazado_ruta(){
    echo "hola"
}


#-----------------------------------------------------------------------------------------------------------------
# Ejecución del script

while [ $OPCN_USUARIO != "9" ]; do
    limpiar_pantalla
    
    mostrar_menu
    
    echo ""
    read -n 1 -p "Seleccione una opción: " OPCN_USUARIO
    echo ""

    case $OPCN_USUARIO in
        1) crear_usuario;;
        2) habilitar_usuarios;;
        3) deshabilitar_usuarios;;
        4) permisos_fichero;;
        5) copia_seguridad_usuario;;
        6) usuarios_conectados_sistema;;
        7) espacio_libre_disco;;
        8) trazado_ruta;;
        9) echo "" && echo "Ejecución finalizada";;
        *) echo "" && echo "Se ha equivocado de número"
    esac

    if [[ $OPCN_USUARIO != "9" ]]; then
        sleep 2s

        echo ""
        read -n 1 -p "Pulse una tecla para continuar..."
    
    fi
done