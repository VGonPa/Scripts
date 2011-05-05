# Author: Víctor González Pacheco <vgonzale@ing.uc3m.es>
# Copyright: (C) 2009 by Víctor González Pacheco

# DESCRIPTION: Script to make easier to connecto to the UC3M VPN

# LICENSE:
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


#!/bin/bash

function ayuda {
	echo "Uso: $0 [OPCION]"
	echo Opciones:
	echo "	conecta		Conectarse a la VPN"
	echo "	desconecta	Desconectarse de la VPN"
	echo "	biblio		Conectarse a la VPN con acceso a recursos bibliográficos"
	echo "	help		Mostrar esta ayuda"
	exit
}


# Si no introduzco ningún parámetro de entrada muestro la ayuda
if [ -z "$1" ]; then
	ayuda
fi


OPCION=$1
CONECTA="conecta"
DESCONECTA="desconecta"
BIBLIO="biblio"
HELP="help"


if [ "$OPCION" = "$BIBLIO" ]; then
	sudo pon uc3m-vpn
	sudo route add default ppp0
	echo "Conectado a la VPN de la universidad con soporte de acceso a los recursos de la biblioteca"
elif [ "$OPCION" = "$CONECTA" ]; then
	sudo pon uc3m-vpn
	echo "Conectado a la VPN de la universidad"
elif [ "$OPCION" = "$DESCONECTA" ]; then
	sudo route del default ppp0
	sudo poff uc3m-vpn
	echo "Desconectado dela VPN de la universidad"
elif [ "$OPCION" = "$HELP" ]; then
	ayuda
	exit
else
	ayuda
	exit
fi
