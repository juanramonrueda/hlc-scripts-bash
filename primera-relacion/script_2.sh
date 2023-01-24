#!/bin/bash


#--------------------------------------------------------------------------------------------------
# Declaración de variables

# Declaración de variable para agregar una cabecera al fichero de salida
CABECERA_SALIDA=NOMBRE-APELLIDO-NOM_USUARIO

# Asignación del primer argumento recibido a una variable
INPUT_FILE="$1"

# Asignación del segundo argumento recibido a una variable
OUTPUT_FILE="$2"


#--------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para limpiar la pantalla
function clear_screen() {
    clear
}


# Función para comprobar el contenido del archivo de salida y realizar el traspaso de información
# del archivo de entrada al fichero de salida sin sobreescribir y sin duplicar, triplicar...
function generate_output_file_content() {
    while IFS= read -r $INPUT_FILE && IFS= read -r $OUTPUT_FILE
    do
        echo "Comprobando contenido de los archivos"
    done < "$OUTPUT_FILE"
}


# Función principal
function main() {
    # Llamada a la función "clear_screen"
    clear_screen

    # Comprobación de la cantidad de argumentos pasados al script
    if [ $# = 2 ]; then

        # Comprobación de que el fichero de entrada existe
        if test -e $1; then

            # Comprobación de que el fichero de salida existe
            if test -e $2; then

                # Llamada a la función que generará el contenido al fichero de salida
                generate_output_file_content

            # Creación del fichero de salida junto a la cabecera en el caso de no existir
            else
                # Mensaje de que se está creando el fichero de salida
                echo "Creando el fichero $2..."

                # Pequeña parada de un segundo
                sleep 1s

                # Creación del archivo y agregación de la cabecera al fichero
                touch $2 && echo "$CABECERA_SALIDA" >> $2

                # Llamada a la función que generará el contenido al fichero de salida
                generate_output_file_content
            fi

        # En el caso de que el fichero de entrada no exista, saldrá de la ejecución del script
        else
            echo "El fichero de entrada $1 no existe, saliendo de la ejecución..."
            
            # Pequeña parada de dos segundos para leer el mensaje
            sleep 2s

            # Salida de la ejecución del script
            exit
        fi

    # En el caso de que se hayan pasado una cantidad distinta a dos argumentos, mostrará los mensajes
    else
        # Muestra la cantidad de argumentos que se han pasado al script
        echo "Ha introducido $# argumentos al script cuando solo se pueden pasar dos"
        echo ""

        echo "Finalizando la ejecución del script..."

        # Pequeña parada de un segundo
        sleep 1s
    fi
}


#--------------------------------------------------------------------------------------------------
# Ejecución del script

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir
# con el nombre del script, se procederá a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
