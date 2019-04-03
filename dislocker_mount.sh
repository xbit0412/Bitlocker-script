#!/bin/bash
#VERSION 1
#   - Corregido que los directorios a veces no se creaban adecuadamente
#VERSION 2
#   - Añadido que el explorador de archivos nautilus se abra tras montar el disco virtual y su descifrado
#VERSION 3
#   - Añadido mensaje de error si el script no es ejecutado como root (permiso de nivel 0)
#   - Añadido que cuando se debe introducir la contraseña de bitlocker la entrada es invisible y ya no se ven las contraseñas
#   - Añadida dedicatoria a una persona
#   - Añadido que el explorador de archivos por defecto del sistema se abra tras montar el disco virtual
#   - Añadido logo propio ascii xbit en el titulo
#VERSION 4
#   - El script genera los directorios de montaje de manera automatica (unidad1, unidad2)
#VERSION 5
#   - Comprueba si el programa esta instalado, en caso de que no lo este lo instala
#   - Asignacion de permisos adecuada
#   - Añadido spam de automatizador Dislocker
#   - Mejorados los textos (eliminacion, sustitucion)
##################################################################    
    if (( EUID != 0 )); then
    echo "Tienes que ejecutar el script como root. Prueba copiando y pegando esto: sudo ./dislocker_mount.sh" 1>&2
    chmod u=rwx,go=r dislocker_mount.sh 
    exit 1
    else
    chmod u=rwx,go=r dislocker_mount.sh 
    fi
programa=dislocker
dpkg -s $programa &> /dev/null
    if [ $? -eq 0 ]; then
    clear
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
    read -p "$programa esta instalado, pulsa una tecla para continuar"
    clear
    else
    clear
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
    read -p "$programa no esta instalado, presiona una tecla para instalarlo" 
    apt-get update
    clear
    apt-get install $programa -y
    clear
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
        elif [ $username = xbit ]; then
            echo    "Hola de nuevo maestro"
        fi

echo
chgrp $username dislocker_mount.sh 
echo
read -p "$username pulsa una tecla para continuar"
#
# Mostrar y seleccionar la unidad de bitlocker
clear
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
lsblk | grep sd
echo "Escribe la unidad USB que quieres montar, por ejemplo sdc5..."
read usb
echo "Has seleccionado el disco $usb, ¡asegurate de que es correcto!"
echo
read -p "$username pulsa una tecla para continuar"
#
# Crear directorios donde sera montado
clear
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
montaje1=unidad1
montaje2=unidad2
#function pause(){
#    read -p "$*"
#}
echo "Se creara la $montaje1 y $montaje2 en /mnt"
echo
read -p 'Presiona enter para continuar'
mkdir /mnt/$montaje1 /mnt/$montaje2
#
# ¡Empezar a montar todo! Montar bitlocker como particion virtual desbloqueandola con la contraseña
clear
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
echo "Escribe la contraseña de bitlocker"
read -s bitlockpass
dislocker-fuse -v -V /dev/$usb -u$bitlockpass -- /mnt/$montaje1
clear
echo "Se ha montado $usb con la contraseña $bitlockpass en /mnt/$montaje1"
clear
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
echo "Ahora se descifrara $montaje1 en $montaje2"
echo
read -p "Pulsa una tecla para continuar"
mount -rw -o loop /mnt/$montaje1/dislocker-file /mnt/$montaje2
#
# Abrir el directorio ya por comodidad, ¿sino pa que?
xdg-open /mnt/$montaje2 &>/dev/null