#!/bin/bash


#----------------------------------------------------------------------------------------------------------------------
# Ejecución del comando find para buscar los *.sh, pasar el contenido a scripts.txt y empaquetar todos los scripts

find /home/rayseink/hlc-scripts-bash -name '*.sh' -exec cat {} >> scripts.txt \; tar -cvf MIS_SCRIPTS.tar {} +
