#! /bin/bash
#################################################################################
#  ____________________________________________________
# |                                                    |
# | Easy Format Usb v1.0.0                             |
# |                                                    |
# | Formatea memorias USB como FAT32 o NTFS fácilmente |
# |____________________________________________________|
#
# Descripción
# ===========
# 
#formatea memorias USB llevelas a FAT32 o NTFS 
#
#
# Requisitos
# ==========
#
# Requiere tener instalados los paquetes sudo (sustituible por "su" 
# Modificando el script), dosfstools y ntfsprogs
#
##################################################################################
#Colores
BLUE="\033[1;34m"
GRAY="\033[1;30m"
GREEN="\033[1;32m"
PINK="\033[1;35m"
RED="\033[1;31m"
WHITE="\033[1;37m"
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"
#Fin de colores
echo -e $YELLOW" Easy USB Format v1.0.0"$ENDCOLOR
lsblk
echo -e $BLUE"Mostrando tabla de particiones y dispositivos de almacenamiento conectados."$ENDCOLOR
DEVICE=0
while [ ! -e /dev/$DEVICE ];do
echo -e $WHITE'Elija la memoria a formatear (solo escriba lo que está después de "/dev/"):'$ENDCOLOR
read DEVICE
if [ -e /dev/$DEVICE ];then
sudo umount /dev/$DEVICE
else
echo -e $RED"No existe el dispositivo, inténte nuevamente."$ENDCOLOR
fi
done
FORMAT=0
while [ $FORMAT != 1 -a $FORMAT != 2 ];do
echo -e $WHITE"Elija el formato:"$ENDCOLOR
echo -e $PINK"1) FAT32"$ENDCOLOR
echo -e $PINK"2) NTFS"$ENDCOLOR
read FORMAT
if [ $FORMAT = 1 ];then
PARAMS='mkfs.vfat -F 32 -n'
FRMTNAME='FAT32'
elif [ $FORMAT = 2 ];then
PARAMS='mkntfs -f -L'
FRMTNAME='NTFS'
else
echo -e $RED"Opción inválida, elija 1 o 2."$ENDCOLOR
fi
done
echo -e $WHITE"Escriba el nombre que desea para la memoria:"$ENDCOLOR
read NAME
echo -e $BLUE'Formateando memoria como "'$NAME'" en '$FRMTNAME', por favor, espere...'$ENDCOLOR
sudo $PARAMS "$NAME" /dev/$DEVICE
echo -e $GREEN"Terminado."$ENDCOLOR
# FIN DEL SCRIPT
#################################################################################
