#!/usr/bin/env sh

# Definición de colores para Polybar
COLOR_PERSONAL="%{F#a6e3a1}"   # Verde
COLOR_NO="%{F#f38ba8}"         # Rojo

CHECK_WG="$(ip a | grep -c wg0)"

if [ "$CHECK_WG" != "2" ]; then
	echo -n "${COLOR_NO}No VPN${COLOR_NO}"
else
	echo -n "${COLOR_PERSONAL}VPN${COLOR_PERSONAL}"
fi
