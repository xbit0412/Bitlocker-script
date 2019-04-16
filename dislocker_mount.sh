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
#VERSION 6
#   - Automatizacion de la insercion del usuario actual
#   - Modificado el mensaje de autor   
#   - Modificado el color de la terminal al ejecutar el script
#VERSION 7
#   - Cambiado el color del texto por uno mas apreciable en ciertos tipos de pantallas
#   - Añadida la instalacion de dialog como dependencia para el script
#   - Añadido menu de seleccion de idioma (Español, Euskera, Ingles)
#   - Por motivos de seguridad, se ha eliminado la cadena que revelaba la contraseña de bitlocker escrita
#   - Corregidas algunas traducciones

# Si el usuario no tiene permisos de root acabar la ejecucion y mostrar un mensaje, sin importar el resultado modificar los permisos del script
    if (( EUID != 0 )); then
    echo "Tienes que ejecutar el script como root. Prueba copiando y pegando esto: sudo ./dislocker_mount.sh" 1>&2
    chmod u=rwx,go=r dislocker_mount.sh 
    exit 1
    else
    chmod u=rwx,go=r dislocker_mount.sh 
    fi

#########################################################################################
# INICIO DEL MENU PARA SELECCIONAR EL IDIOMA
alto=15
ancho=40
anchoeleccion=4
esquina_off=""
titulo="SCRIPT DISLOCKER"
texto="ELIGE UN IDIOMA\nAUKERATU LENGUAIA\nCHOOSE LANGUAGE"

opciones=(1 "Español"
         2 "Euskera"
         3 "Ingles")

eleccion=$(dialog --clear \
                --backtitle "$esquina_off" \
                --title "$titulo" \
                --menu "$texto" \
                $alto $ancho $anchoeleccion \
                "${opciones[@]}" \
                2>&1 >/dev/tty)
clear
case $eleccion in
        1)
            ######################################################################################

                # Cambiar el color de la terminal a partir de aqui
                printf '\e[33;1;33m Foreground color: red\n'
                printf '\e[48;5;0m Background color: black\n'
                printf '\e[K'

                ########################################################################################
                # Version script ESPAÑOL
                programa=dislocker
                programa2=dialog
                dpkg -s $programa $programa2 &> /dev/null
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
                    read -p "$programa y $programa2 estan instalados, pulsa intro para continuar"
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
                    read -p "$programa y $programa2 no esta instalado, presiona intro para instalarlo" 
                    apt-get update
                    clear
                    apt-get install $programa $programa2 -y
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
                    username=`logname`
                    echo "Se esta determinando tu nombre de usuario en el sistema..."
                    chown $username dislocker_mount.sh 

                            if [ $username = jans ]; then
                                echo "Gracias por inspirarme $username :)"
                            elif [ $username = xbit ]; then
                                echo    "I'm here to serve $username"
                            fi

                    echo
                    chgrp $username dislocker_mount.sh 
                    echo
                    read -p "$username pulsa intro para continuar"
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
                    read -p "$username pulsa intro para continuar"
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
                    echo "Se ha montado $usb en /mnt/$montaje1"
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
                    read -p "Pulsa intro para continuar"
                    mount -rw -o loop /mnt/$montaje1/dislocker-file /mnt/$montaje2
                    #
                    # Abrir el directorio ya por comodidad, ¿sino pa que?
                    xdg-open /mnt/$montaje2 &>/dev/null
                break
                ;;

        2)

            ######################################################################################

            # Cambiar el color de la terminal a partir de aqui
            printf '\e[33;1;33m Foreground color: red\n'
            printf '\e[48;5;0m Background color: black\n'
            printf '\e[K'

            ########################################################################################
            # Version script EUSKERA
            programa=dislocker
            programa2=dialog
            dpkg -s $programa $programa2 &> /dev/null
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
                read -p "$programa eta $programa2 instalatuta daude, sakatu sartu tekla"
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
                read -p "$programa eta $programa2 ez daude instalatuta, sakatu sartu tekla instalatzeko" 
                apt-get update
                clear
                apt-get install $programa $programa2 -y
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
                username=`logname`
                echo "Ateratzen erabiltzailearen izena..."
                chown $username dislocker_mount.sh 

                        if [ $username = jans ]; then
                            echo "Eskerrik inspirazioagatik $username :)"
                        elif [ $username = xbit ]; then
                            echo    "I'm here to serve $username"
                        fi

                echo
                chgrp $username dislocker_mount.sh 
                echo
                read -p "$username sakatu sartu tekla jarraitzeko"
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
                
                echo "Idatzi muntatu nahi duzun USB unitatea, adibidez sdc5..."
                read usb
                echo "$usb aukeratu duzu, ziurtatu ondo ipinita dagoela!"
                echo
                read -p "$username sakatu sartu tekla jarraitzeko"
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
                
                echo "$montaje1 y $montaje2 egingo dira /mnt direktorioan"
                echo
                read -p 'Sakatu sartu tekla jarraitzeko'
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
                echo "Idatz ezazu zure bitlocker pasahitza"
                read -s bitlockpass
                dislocker-fuse -v -V /dev/$usb -u$bitlockpass -- /mnt/$montaje1
                clear
                echo "$usb muntatu da /mnt/$montaje1 direktorioan"
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
                echo "$montaje1 deszifratuko da $montaje2 direktorioan"
                echo
                read -p "Sakatu sartu tekla jarraitzeko"
                mount -rw -o loop /mnt/$montaje1/dislocker-file /mnt/$montaje2
                #
                # Abrir el directorio ya por comodidad, ¿sino pa que?
                xdg-open /mnt/$montaje2 &>/dev/null
                break
                ;;

        3)
            ######################################################################################

            # Cambiar el color de la terminal a partir de aqui
            printf '\e[33;1;33m Foreground color: red\n'
            printf '\e[48;5;0m Background color: black\n'
            printf '\e[K'

            ########################################################################################
            # Version script INGLES
            programa=dislocker
            programa2=dialog
            dpkg -s $programa $programa2 &> /dev/null
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
                read -p "$programa and $programa2 are installed, press enter"
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
                read -p "$programa eta $programa2 aren't installed, press enter to install" 
                apt-get update
                clear
                apt-get install $programa $programa2 -y
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
                username=`logname`
                echo "Obtaining username..."
                chown $username dislocker_mount.sh 

                        if [ $username = jans ]; then
                            echo "Thanks $username for inspire me :)"
                        elif [ $username = xbit ]; then
                            echo    "I'm here to serve $username"
                        fi

                echo
                chgrp $username dislocker_mount.sh 
                echo
                read -p "$username press enter to continue"
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
                echo "Write USB device you will mount, for example sdc5..."
                read usb
                echo "You choice is $usb, check is correct!"
                echo
                read -p "$username press enter to continue"
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
                
                echo "$montaje1 and $montaje2 will be created in /mnt folder"
                echo
                read -p 'Press enter to continue'
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
                echo "Write your bitlocker password"
                read -s bitlockpass
                dislocker-fuse -v -V /dev/$usb -u$bitlockpass -- /mnt/$montaje1
                clear
                echo "$usb mounted in /mnt/$montaje1 folder"
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
                echo "$montaje1 will decipher at $montaje2 folder"
                echo
                read -p "Press enter to continue"
                mount -rw -o loop /mnt/$montaje1/dislocker-file /mnt/$montaje2
                #
                # Abrir el directorio ya por comodidad, ¿sino pa que?
                xdg-open /mnt/$montaje2 &>/dev/null
                break
                exit 1;
                ;;
            
esac