#!/bin/bash


#--------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Variable que contiene una expresión regular para comprobar que se introducen únicamente números (enteros, decimales...)
COMPROBACION_NUMERO='^[-+]?[0-9]+\.?[0-9]*$'

# Variable que contiene una expresión regular para comprobar que únicamente se introducen operadores matemáticos
COMPROBACION_OPERACION='[%*+-/]'

# Se pasa el contenido del primer argumento recibido a otra variable y se convierte en "global" con export para las funciones
export PRIMER_ARGUMENTO="$1"

# Se pasa el contenido del segundo argumento recibido a otra variable y se convierte en "global" con export para las funciones
export SEGUNDO_ARGUMENTO="$2"

# Se pasa el contenido del terce argumento recibido a otra varaible y se convierte en "global" con export para las funciones
export TERCER_ARGUMENTO="$3"


#--------------------------------------------------------------------------------------------------------------------------------
# Declaración de funciones

# Función para limpiar la pantalla antes de realizar las operaciones necesarias
function clear_screen() {
    clear
}


# Función para realizar la suma de los dos argumentos
function suma() {
    RESULTADO=$( echo "($PRIMER_ARGUMENTO + $SEGUNDO_ARGUMENTO)" | bc -l )
    echo "Se ha realizado la suma de ambos números --> $PRIMER_ARGUMENTO + $SEGUNDO_ARGUMENTO = $RESULTADO"
}


# Función para realizar la resta de los dos argumentos
function resta() {
    RESULTADO=$( echo "($PRIMER_ARGUMENTO - $SEGUNDO_ARGUMENTO)" | bc -l )
    echo "Se ha realizado la resta de ambos números --> $PRIMER_ARGUMENTO - $SEGUNDO_ARGUMENTO = $RESULTADO"
}


# Función para realizar la multiplicación de los dos argumentos
function multiplicacion() {
    RESULTADO=$( echo "($PRIMER_ARGUMENTO * $SEGUNDO_ARGUMENTO)" | bc -l )
    echo "Se ha realizado la multiplicación de ambos números --> $PRIMER_ARGUMENTO * $SEGUNDO_ARGUMENTO = $RESULTADO"
}


# Función para realizar la división de los dos argumentos y obtener el cociente
function division() {
    RESULTADO=$( echo "($PRIMER_ARGUMENTO / $SEGUNDO_ARGUMENTO)" | bc -l )
    echo "Se ha realizado la división de ambos números para obtener el cociente --> $PRIMER_ARGUMENTO / $SEGUNDO_ARGUMENTO = $RESULTADO"
}


# Función para realizar la división de los dos argumentos y obtener el resto
function modulo() {
    RESULTADO=$( echo "($PRIMER_ARGUMENTO % $SEGUNDO_ARGUMENTO)" | bc -l )
    echo "Se ha realizado la división de ambos números para obtener el resto --> $PRIMER_ARGUMENTO % $SEGUNDO_ARGUMENTO = $RESULTADO"
}


# Función para realizar las operaciones matemáticas
function calculadora() {

    # En el caso de que el tercer argumento sea para realizar la suma, llamará a la función que realiza la operación
    if [[ $TERCER_ARGUMENTO == '+' ]]; then
        suma

    # En el caso de que el tercer argumento sea para realizar la resta, llamará a la función que realiza la operación
    elif [[ $TERCER_ARGUMENTO == '-' ]]; then
        resta

    # En el caso de que el tercer argumento sea para realizar la multiplicación, llamará a la función que realiza la operación
    elif [[ $TERCER_ARGUMENTO == '*' ]]; then
        multiplicacion

    # En el caso de que el tercer argumento sea para realizar la división y obtener el cociente, llamará a la función que realiza la operación
    elif [[ $TERCER_ARGUMENTO == '/' ]]; then
        division

    # En el caso de que el tercer argumento sea para realizar la división y obtener el resto, llamará a la función que realiza la operación
    elif [[ $TERCER_ARGUMENTO == '%' ]]; then
        modulo
    fi
}


# Función principal para validar los argumentos dados
function main() {
    # Llamada a la función para limpiar la pantalla
    clear_screen

    # En el caso de que los argumentos pasados coincidan con la cantidad de argumentos necesarios, procederá con la ejecución
    if [[ $# == "3" ]]; then

        # Comprobación de que el primer argumento dado es un número
        if [[ $1 =~ $COMPROBACION_NUMERO ]]; then
            
            # Comprobación de que el segundo argumento dado es un número
            if [[ $2 =~ $COMPROBACION_NUMERO ]]; then
                
                # Comprobación de que el tercer argumento dado es una expresión utilizada en matemáticas
                if [[ $3 =~ $COMPROBACION_OPERACION ]]; then
                    calculadora

                # Mensaje de que el tercer argumento dado no es un símbolo de expresión matemática
                else
                    echo "El tercer argumento dado, \"$TERCER_ARGUMENTO\", no es una expresión matemática"
                fi
            
            # Mensaje de que el segundo argumento dado no es un número    
            else
                echo "El segundo argumento dado, \"$SEGUNDO_ARGUMENTO\", no es un número"
            fi

        # Mensaje de que el primer argumento dado no es un número
        else
            echo "El primer argumento dado, \"$PRIMER_ARGUMENTO\", no es un número"
        fi

    # En el caso de que los argumentos pasados no sean igual a tres, se finalizará por defecto la ejecución
    else
        # Mensajes para el usuario
        echo "Solo se pueden pasar tres argumentos, usted ha pasado: $#"
        echo ""
        echo "Finalizando la ejecución..."
        
        # Parada de dos segundos
        sleep 2s
    fi
}


#--------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir con el nombre del script,
# se procederá a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi