#!/bin/bash
#  VERSION 1
#   - Corregido que los directorios a veces no se creaban adecuadamente
#  Version 2
#   - Añadido que el explorador de archivos nautilus se abra tras montar el disco virtual y su descifrado
# VERSION 3
#   - Añadido mensaje de error si el script no es ejecutado como root (permiso de nivel 0)
#   - Añadido que cuando se debe introducir la contraseña de bitlocker la entrada es invisible y ya no se ven las contraseñas
#   - Añadida dedicatoria a una persona
#   - Añadido que el explorador de archivos por defecto del sistema se abra tras montar el disco virtual
#   - Añadido logo propio ascii xbit en el titulo
    if (( EUID != 0 )); then
    echo "Tienes que ejecutar el script como root. Prueba copiando y pegando esto: sudo ./dislocker_mount.sh" 1>&2
    exit 1
    fi
echo "######################################"
echo "#      Automatizador Dislocker       #"
echo "#------------------------------------#"
echo "#               _      _  _          #"
echo "#        __  __| |__  (_)| |_        #"
echo "#        \ \/ /| '_ \ | || __|       #"
echo "#         >  < | |_) || || |_        #"
echo "#        /_/\_\|_.__/ |_| \__|       #"        
echo "######################################"
echo
echo
echo "Escribe tu nombre de usuario de sistema"
read username
chown $username dislocker_mount.sh 

        if [ $username = jans ]; then
            echo "Gracias por inspirarme :)"
        fi

echo
chgrp $username dislocker_mount.sh 
echo
read -p "Pulsa una tecla para continuar"
#
# Mostrar y seleccionar la unidad de bitlocker
clear
lsblk | grep sd
echo "Escribe la unidad USB que quieres montar, por ejemplo sdc5... el que mas ocupa"
read usb
echo "Has seleccionado el disco $usb, ¡asegurate de que es correcto! Aunque salgan errores no pasa nada, simplemente continua"
echo
read -p "Pulsa una tecla para continuar"
#
# Crear directorios donde sera montado
clear
echo "Escribe un nombre de montaje en el directorio /mnt"
read montaje1
echo "Has seleccionado $montaje1"
clear
echo "Escribe otro nombre de montaje en el directorio /mnt"
read montaje2
echo "Has seleccionado $montaje1 y $montaje2, creando directorios..."
mkdir /mnt/$montaje1 /mnt/$montaje2
echo
#
# ¡Empezar a montar todo! Montar bitlocker como particion virtual desbloqueandola con la contraseña
clear
echo "Escribe la contraseña de bitlocker"
read -s bitlockpass
dislocker-fuse -v -V /dev/$usb -u$bitlockpass -- /mnt/$montaje1
clear
echo "Se ha montado $usb con la contraseña $bitlockpass en /mnt/$montaje1"
clear
echo "Ahora toca montar el contenido descifrado de $montaje1 en $montaje2"
echo
read -p "Pulsa una tecla para continuar"
mount -rw -o loop /mnt/$montaje1/dislocker-file /mnt/$montaje2
#
# Abrir el directorio ya por comodidad, ¿sino pa que?
xdg-open /mnt/$montaje2 &>/dev/null
