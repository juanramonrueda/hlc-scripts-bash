#!/bin/bash


#---------------------------------------------------------------------------------------------------------------------------
# Declararación de variables

# Conversión del primer argumento recibido a variable
NET_ADDRESS="$1"

# Contador para conocer los hosts activos
CONTADOR_ACTIVOS=0

# Nombre del directorio en el que se guardarán los archivos de escaneo
DIRECTORIO_ESCANEO="nmap_txt"

# Nombre del archivo
NOMBRE_FICHERO="Red-$NET_ADDRESS.txt"

# Obtención del usuario que ejecuta el script para obtener su directorio personal
RUTA_DIRECTORIO_USUARIO=$( eval echo "~$USUARIO" )

# Concatenación del directorio personal del usuario y el directorio en el que se guardarán los ficheros
RUTA_DIRECTORIO_FICHEROS="$RUTA_DIRECTORIO_USUARIO/$DIRECTORIO_ESCANEO"

# Concatenación del directorio personal del usuario, el directorio en el que se guardarán los ficheros y el fichero final
RUTA_COMPLETA_FICHERO="$RUTA_DIRECTORIO_FICHEROS/$NOMBRE_FICHERO"


#---------------------------------------------------------------------------------------------------------------------------
# Declaración de función
function main() {
    # Comprobación de que el directorio para los archivos exista
    if [[ ! -d $RUTA_DIRECTORIO_FICHEROS ]]; then
        mkdir $RUTA_DIRECTORIO_FICHEROS
    fi

    # Obtención de la IP sin el último octeto
    NO_ZERO_IP=$( echo "$NET_ADDRESS" | cut -d "." -f 1,2,3 )

    # Bucle para recorrer toda la red y hacer ping a las IPs
    for CUARTO_OCTETO in `seq 1 1 254`
    do
        # Progreso del escaneo, no se guarda en el archivo
        echo "Pinging to $NO_ZERO_IP.$CUARTO_OCTETO"
        
        # Ping a la IP que está en ese momento en el bucle y su salida se manda a NULL
        ping -c 1 "$NO_ZERO_IP.$CUARTO_OCTETO" >/dev/null 2>&1

        # Obtención del RC del comando para saber si ha sido exitoso el ping o no
        RESULTADO=$( echo $? )

        # Comparación del resultado del ping para saber si el host estaba UP or DOWN
        if [[ $RESULTADO -eq 0 ]]; then
            # Se usa DATE para saber la hora a la que se realiza el ping y se pasa por pipeline a TEE -A para añadir al fichero
            echo "($(date +%H:%M:%S)) El host $NO_ZERO_IP.$CUARTO_OCTETO está activo" | tee -a $RUTA_COMPLETA_FICHERO

            # Incremento de la variable contadora para saber cuántos hosts están activos
            let "CONTADOR_ACTIVOS++"
        fi
    done

    # Mensaje de que el escaneo de la red ha finalizado
    echo "Escaneo finalizado" && echo ""

    # Mensaje de cuántos hosts estaban activos al momento de realizar el escaneo de la red
    echo "Se han encontrado $CONTADOR_ACTIVOS host activos"
}


#---------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función principal

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi