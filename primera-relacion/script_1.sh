#!/bin/bash


#-------------------------------------------------------------------------------------------------------------------------------------------
# Declaración de variables

# Variable para entrar en el bucle de la función principal
OPCN_USUARIO=1

# Variable contadora para mostrar la primera vez el avido de sudo
CONTADOR=0


#-------------------------------------------------------------------------------------------------------------------------------------------
# Definición de funciones

# Creación de usuario
function crear_usuario(){
  # Petición del nombre de usuario que hay que crear
  read -p "Introduzca el nombre del usuario que quiere crear: " NOMBRE_USUARIO
  
  # Se usa -n 1 para no tener que pulsar la tecla Intro y continuar en cuanto se introduzca un carácter
  echo "" && read -n 1 -p "¿Quiere crear el usuario con directorio personal? (S/N): " RESPUESTA

  # Comprobación si el usuario tendrá o no directorio personal
  if [[ ${RESPUESTA} == "s" || ${RESPUESTA} == "S" ]]; then
    # ADDUSER crea el usuario con la contraseña que tendrá y además crea el directorio personal
    adduser ${NOMBRE_USUARIO}

  else
    # USERADD crea directamente el usuario sin directorio personal y sin contraseña
    useradd ${NOMBRE_USUARIO}

    # Se indica que se introduzca una contraseña para el usuario creado
    echo "" && echo "Introduzca la contraseña para el usuario"
    
    # Se ejecuta el comando para asignar una contraseña al usuario creado
    passwd ${NOMBRE_USUARIO}

  fi

  # Se muestra el último registro para mostrar el usuario creado
  echo "" && tail -n -1 /etc/passwd
}


# Habilitación de usuarios que se encuentran deshabilitados
function habilitar_usuarios(){
  read -p "Introduzca el usuario que quiere habilitar: " NOMBRE_USUARIO

  # Se guarda en variable el primer carácter de la contraseña cifrada para saber el estado del usuario
  COMPROBACION_DESHABILITACION=$( cat /etc/shadow | grep ${NOMBRE_USUARIO} | cut -d ":" -f 2 | cut -c 1 )

  # Comprobación del carácter guardado en la anterior variable, en el caso de que sea "!", está deshabilitado 
  if [[ ${COMPROBACION_DESHABILITACION} != "!" ]]; then
    echo "El usuario se encuentra habilitado, por lo que no se realizará ninguna operación"
  
  # En el caso de que empiece por "!", se habilitará el usuario
  else
    passwd -u ${NOMBRE_USUARIO}

    echo "El usuario se ha habilitado"
  fi
}


# Deshabilitación de usuarios
function deshabilitar_usuarios() {
  read -p "Introduzca el usuario que quiere deshabilitar: " NOMBRE_USUARIO

  passwd -l ${NOMBRE_USUARIO}
}


# Cambio de permisos de un fichero para un usuario
function permisos_fichero(){
  # Se inicializa la variable a 1 para el primer bucle FOR
  LISTADO_NIVELES=1

  # Se inicializa la variable a 1 para el segundo bucle FOR
  COMPROBACION_DIRECTORIO=1

  echo "" && read -p "Introduzca la ruta absoluta del fichero al que quiere cambiar los permisos: " RUTA_NOMBRE_FICHERO

  # Obtención de la cantidad de niveles hasta llegar al archivo mediante el conteo del símbolo "/"
  CANTIDAD_NIVELES=$( echo "${RUTA_NOMBRE_FICHERO}" | grep -o "/" | wc -l )

  # Se recorren los niveles para realizar un cut -f y obtener la ruta en la que se encuentra el archivo
  for NIVELES in $(seq 1 1 ${CANTIDAD_NIVELES})
  do
    # Guarda en la variable --> 1,1,2... así hasta el nivel establecido en la variable ${CANTIDAD_NIVELES}
    LISTADO_NIVELES="${LISTADO_NIVELES},${NIVELES}"
  done

  # Se obtiene en variable la ruta del archivo, sin agregar a la variable el archivo
  RUTA_FICHERO=$( echo "${RUTA_NOMBRE_FICHERO}" | cut -d "/" -f ${LISTADO_NIVELES} )

  # Se guarda en variable el número del nivel en el que se encuentra el archivo
  NIVEL_FICHERO=$(( ${CANTIDAD_NIVELES} + 1 ))

  # Se obtiene únicamente el nombre del archivo en variable usando la operación anterior
  NOMBRE_FICHERO=$( echo "${RUTA_NOMBRE_FICHERO}" | cut -d "/" -f ${NIVEL_FICHERO} )

  # Se guarda en variable el nivel del directorio que contiene el archivo 
  COMPROBACION_DIRECTORIO_NIVEL=$(( ${CANTIDAD_NIVELES} - 1 ))

  # Se recorren los niveles para realizar un cut -f y obtener la ruta del directorio del archivo
  for NIVELES in $(seq 1 1 ${COMPROBACION_DIRECTORIO_NIVEL})
  do
    # Guarda en la variable --> 1,1,2... así hasta el nivel establecido en la variable ${COMPROBACION_DIRECTORIO_NIVEL}
    COMPROBACION_DIRECTORIO="${COMPROBACION_DIRECTORIO},${NIVELES}"
  done

  # Se obtiene en variable la ruta del directorio que puede dar fallos por un error al escribirlo
  COMPROBACION_DIRECTORIO_EXISTENCIA=$( echo "${RUTA_NOMBRE_FICHERO}" | cut -d "/" -f ${COMPROBACION_DIRECTORIO} )

  # Se comprueba si la ruta y el archivo introducido por el usuario existe
  if test -e ${RUTA_NOMBRE_FICHERO} ; then
    # Se muestran los permisos actuales del fichero que se quiere modificar
    echo "" && echo "Permisos de Usuario: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 2-4 )

    echo "" && echo "Permisos de Grupo: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 5-7 )
    
    echo "" && echo "Permisos de Otros: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 8-10 )
    
    echo "" && echo "r => Lectura | w => Escritura | x => Ejecución | - => Sin permiso"
    
    echo "" && read -n 1 -p "¿Quiere cambiar los permisos? (S/N): " RESPUESTA

    # Se comprueba si el usuario quiere cambiar los permisos
    if [[ ${RESPUESTA} = "S" || ${RESPUESTA} = "s" ]] ; then
      echo "Escriba las letras (en el orden anterior establecido) o símbolos para asignar los permisos"

      # Se recorren los tres tipos de grupos de permisos que tiene un archivo o directorio
      for GRUPOS in Usuario Grupo Otros ; do
        # Se pregunta por los permisos que quiere poner al fichero
        echo "" && read -p "Introduzca los permisos de ${GRUPOS}: " PERMISOS

        # Se convierten los permisos introducidos por el usuario a mayúsculas para que funcione el CASE
        PERMISOS_MAY=$( echo $PERMISOS | tr [a-z] [A-Z] )

        # Cuando entre el FOR en Usuario, realizará los cambios introducidos por el usuario
        if [ ${GRUPOS} = Usuario ] ; then
          case ${PERMISOS_MAY} in
            RWX) chmod u+rwx ${RUTA_NOMBRE_FICHERO};;
            RW-) chmod u+rw-x ${RUTA_NOMBRE_FICHERO};;
            R-X) chmod u+rx-w ${RUTA_NOMBRE_FICHERO};;
            R--) chmod u+r-wx ${RUTA_NOMBRE_FICHERO};;
            -WX) chmod u+wx-r ${RUTA_NOMBRE_FICHERO};;
            -W-) chmod u+w-rx ${RUTA_NOMBRE_FICHERO};;
            --X) chmod u+x-rw ${RUTA_NOMBRE_FICHERO};;
            ---) chmod u-rwx ${RUTA_NOMBRE_FICHERO};;
          esac

        # Cuando entre el FOR en Grupo, realizará los cambios introducidos por el usuario
        elif [ ${GRUPOS} = Grupo ] ; then
          case ${PERMISOS_MAY} in
            RWX) chmod g+rwx ${RUTA_NOMBRE_FICHERO};;
            RW-) chmod g+rw-x ${RUTA_NOMBRE_FICHERO};;
            R-X) chmod g+rx-w ${RUTA_NOMBRE_FICHERO};;
            R--) chmod g+r-wx ${RUTA_NOMBRE_FICHERO};;
            -WX) chmod g+wx-r ${RUTA_NOMBRE_FICHERO};;
            -W-) chmod g+w-rx ${RUTA_NOMBRE_FICHERO};;
            --X) chmod g+x-rw ${RUTA_NOMBRE_FICHERO};;
            ---) chmod g-rwx ${RUTA_NOMBRE_FICHERO};;
          esac

        # Cuando entre el FOR en Otros, realizará los cambios introducidos por el usuario
        else
          case ${PERMISOS_MAY} in
            RWX) chmod o+rwx ${RUTA_NOMBRE_FICHERO};;
            RW-) chmod o+rw-x ${RUTA_NOMBRE_FICHERO};;
            R-X) chmod o+rx-w ${RUTA_NOMBRE_FICHERO};;
            R--) chmod o+r-wx ${RUTA_NOMBRE_FICHERO};;
            -WX) chmod o+wx-r ${RUTA_NOMBRE_FICHERO};;
            -W-) chmod o+w-rx ${RUTA_NOMBRE_FICHERO};;
            --X) chmod o+x-rw ${RUTA_NOMBRE_FICHERO};;
            ---) chmod o-rwx ${RUTA_NOMBRE_FICHERO};;
          esac
        fi
      done

      # Se muestran los nuevos permisos del fichero al usuario para comprobación de los cambios
      echo "" && echo "Los nuevos permisos del fichero ${RUTA_NOMBRE_FICHERO} son:"

      echo "" && echo "Permisos del Usuario: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 2-4 )
      
      echo "" && echo "Permisos del Grupo: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 5-7 )
      
      echo "" && echo "Permisos de Otros: "$( ls -ld ${RUTA_NOMBRE_FICHERO} | cut -c 8-10 )

    # En el caso de que el usuario no quiera realizar cambios en los permisos, se muestra el mensaje
    else
      echo "" && echo "Los permisos del fichero no han sufrido modificación alguna"
    fi
    
  # En el caso de que haya algún error al introducir la ruta del fichero se mostrará el posible error
  else
    # En el caso de que no exista el fichero en la ruta, mostrará los directorios y archivo del nivel
    if test -e ${RUTA_FICHERO} ; then
      echo "El archivo $NOMBRE_FICHERO no existe en la ruta" ${RUTA_FICHERO}

      echo "" && echo "Estos son los ficheros y directorios que se encuentran en la ruta:"
      ls -l ${RUTA_FICHERO} | cut -d " " -f 9

    # En el caso de que no exista la ruta del directorio, mostrará los directorios que contiene el nivel anterior
    else
      echo "" && echo "No existe la ruta en la que se encuentra el archivo, posiblemente tiene un error"
    
      echo "" && echo "Estos son los directorios y archivos del nivel anterior al fallo:"
      ls -l ${COMPROBACION_DIRECTORIO_EXISTENCIA} | cut -d " " -f 9
    fi
  fi
}


# Copia de seguridad del directorio personal de un usuario
function copia_seguridad_usuario(){
  DIRECTORIO_COPIAS_SEGURIDAD="/copias_seguridad_usuarios"

  # Petición del nombre de usuario para realizar la copia de seguridad de su directorio personal
  read -p "Introduzca el nombre del usuario del cuál quiere hacer una copia de seguridad de su directorio personal: " USUARIO

  # Se comprueba si el usuario especificado existe en el sistema, redirigiendo la salida normal (1) y de error (2) a null
  # Con id "${USUARIO}" se muestra información sobre el usuario y en caso de existir, entra en el IF
  if id "${USUARIO}" >/dev/null 2>&1; then
  
    # Comprobación de la existencia del directorio que contendrá las copias de seguridad
    # En este caso comprueba de que no existe mediante "!" y -d para directorios
    if [[ ! -d ${DIRECTORIO_COPIAS_SEGURIDAD} ]]; then
      # Creación del directorio que contendrá las copias de seguridad
      mkdir -p ${DIRECTORIO_COPIAS_SEGURIDAD}

      # Se muestra la creación del directorio que contendrá las copias de seguridad
      echo "" && echo "Se ha creado el directorio ${DIRECTORIO_COPIAS_SEGURIDAD}"
    fi

    # Se obtiene la ruta del directorio personal del usuario mediante echo "~${USUARIO}"
    # El comando "eval" se usa para evaluar la expresión siguiente al comando y obtener la ruta
    RUTA_DIRECTORIO_USUARIO=$( eval echo "~${USUARIO}" )

    # Se guarda en variable el nombre que tendrá el archivo comprimido del directorio personal del usuario con el nombre, fecha y hora 
    NOMBRE_BACKUP="${USUARIO}-home_$(date +%Y%m%d_%H%M%S).tar.gz"

    # Se realiza la compresión del contenido del directorio personal del usuario
    tar -czvf ${DIRECTORIO_COPIAS_SEGURIDAD}/${NOMBRE_BACKUP} ${RUTA_DIRECTORIO_USUARIO}

    # Se muestra un mensaje y el contenido del directorio que contiene las copias de seguridad
    echo "" && echo "Archivos del directorio ${DIRECTORIO_COPIAS_SEGURIDAD}:"

    echo "" && ls ${DIRECTORIO_COPIAS_SEGURIDAD}

  # En caso de no existir el usuario en el sistema, avisa al usuario
  else 
    echo "" && echo "El usuario ${USUARIO} no existe en el sistema"
  fi
}


# Usuarios conectados en el sistema
function usuarios_conectados_sistema(){
  who
}


# Espacio libre en el disco duro
function espacio_libre_disco(){
  # Se muestran todas las particiones para discos duros
  ls /dev/sd*

  # Se pide que el usuario introduzca la partición de la que quiere obtener su espacio libre
  read -p "Introduzca la partición de la que quiere obtener su espacio libre: " PARTICION

  # Con el comando df se muestra la partición para "human-readable" y con output se selecciona la fuente y el espacio disponible
  echo "" && df -h ${PARTICION} --output=source,avail
}


# Trazado de ruta desde el origen hasta la IP o URL de destino
function trazado_ruta(){
  # Declaración de variable para OpenSUSE
  OPENSUSE_NAME='NAME="SLES"'

  # Guardado en variable del nombre filtrado del sistema operativo
  OPERATIVE_SYSTEM=$( cat /etc/os-release | grep -w NAME )

  # Comprobación del sistema operativo que se ha guardado en variable
  if [ "${OPERATIVE_SYSTEM}" == "${OPENSUSE_NAME}" ]; then
    # Guardado en variable del estado de traceroute en OpenSUSE
    COMPROBACION_TRACEROUTE_SUSE=$( zypper search traceroute | grep traceroute | cut -d "|" -f 1 )

    if [[ ${COMPROBACION_TRACEROUTE_SUSE} == "i+" ]]; then
      # Petición de la IP o URL
      echo "" && read -p "Introduzca la IP o URL a la que quiere hacer el trazado " IP_URL

      # Trazado de la IP o URL pedida
      traceroute ${IP_URL}

      # En el caso de que traceroute no esté instalado, procederá con la instalación de traceroute
    else
      echo "" && echo "Traceroute no está instalado y se procederá con la instalación (posiblemente se necesite introducir contraseña)"

      # Pequeña parada de tres segundos para leer el anterior mensaje
      sleep 3s

      # Actualización de los repositorios e instalación de traceroute desatendida
      zypper refresh && zypper -n install traceroute

      # Petición de la IP o URL a la que hacer el trazado
      echo "" && read -p "Introduzca la IP o URL a la que quiere hacer el trazado " IP_URL

      # Trazado de la IP o URL pedida
      echo "" && traceroute ${IP_URL}
    fi

  # En el caso de ser distinto de OpenSUSE, entrará en esta condición
  else
    # Guardado en variable del estado de traceroute
    COMPROBACION_TRACEROUTE=$( apt list traceroute | grep "instalado" | cut -c 1-10 )

    # En el caso de que traceroute esté instalado, procederá con la pregunta sobre la IP o URL
    if [[ ${COMPROBACION_TRACEROUTE} == "traceroute" ]]; then
      # Petición de la IP o URL
      echo "" && read -p "Introduzca la IP o URL a la que quiere hacer el trazado: " IP_URL

      # Trazado de la IP o URL pedida
      traceroute ${IP_URL}

    # En el caso de que no esté instalado traceroute, se procederá con la instalación de traceroute
    else
      echo "" && echo "Traceroute no está instalado y se procederá con la instalación (posiblemente se necesite introducir contraseña)"

      # Pequeña parada de tres segundos para leer el anterior mensaje
      sleep 3s

      # Actualización de los repositorios e instalación de traceroute desatendida
      echo "" && apt update && apt install traceroute -y

      # Petición de la IP o URL a la que hacer el trazado
      echo "" && read -p "Introduzca la IP o URL a la que quiere hacer el trazado: " IP_URL

      # Trazado de la IP o URL pedida
      echo "" && traceroute ${IP_URL}
    fi
  fi
}


# Función que contiene el loop del programa
function loop_execution() {
  while [[ ${OPCN_USUARIO} != "9" ]]; do
    # Llamada a la función que limpia la pantalla del script clear_screen.sh
    clear_screen

    if (( ${CONTADOR} <= 0 )); then
      # Llamada a la función que avisa del uso de sudo al usuario del script menu.sh
      aviso_sudo
    fi

    # Se llama a la función que contiene las opciones disponibles del script menu.sh
    opciones_disponibles  

    # Petición de una opción al usuario
    echo -e "\e[38;5;123m" && read -n 1 -p "Seleccione una opción: " OPCN_USUARIO && echo -e "\e[0m"

    # Comparación de la opción introducida por el usuario con las opciones disponibles y llamada a su función
    case ${OPCN_USUARIO} in
      1) crear_usuario;;
      2) habilitar_usuarios;;
      3) deshabilitar_usuarios;;
      4) permisos_fichero;;
      5) copia_seguridad_usuario;;
      6) usuarios_conectados_sistema;;
      7) espacio_libre_disco;;
      8) trazado_ruta;;
      9) echo "" && echo -e "\e[38;5;85mEjecución finalizada\e[0m";;
      *) echo "" && echo -e "\e[38;5;196mSe ha equivocado\e[0m";;
    esac

    # En el caso de que la entrada de la opción sea distinta de "9", hará una pequeña espera y pedirá una pulsación de tecla
    if [[ ${OPCN_USUARIO} != "9" ]]; then
      sleep 1s

      echo -e "\e[38;5;211m" && read -n 1 -p "Pulse la tecla Intro para continuar..." && echo -e "\e[0m"
    fi

    # Incremento de la variable contadora
    CONTADOR=$(( ${CONTADOR} + 1 ))
  done
}


# Función principal
function main() {
  # Importación de los módulos necesarios para el script
  source modules/clear_screen.sh
  source modules/help.sh
  source modules/menu.sh
  
  # Comprobación de si hay argumento
  if (( ${#} == 0 )); then
    # Llamada a la función que contiene el flujo de la ejecución del script
    loop_execution
  
  elif (( ${#} == 1 )); then
    if [[ ${1} == "-h" || ${1} == "--help" ]]; then
      # Llamada a la función que muestra la ayuda del script help.sh
      ayuda
    else
    
      # Llamada a la función que muestra el error en cuanto a la petición de ayuda 
      error_ayuda
    fi
  fi
}


#-------------------------------------------------------------------------------------------------------------------------------------------
# Ejecución de la función "main"

# Con BASH_SOURCE[0] se obtiene la ruta de la ejecución del script que en el caso de coincidir con el nombre del script, se procederá
# a la ejecución de la función que contiene dentro

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "${@}"
fi