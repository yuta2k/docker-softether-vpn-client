#!/bin/sh
set -e

while true
do
  printf "READY\n"

  while read line
  do
    printf "$line" 1>&2
    
    rm -f /usr/vpnclient/vpn_client.config
    
    if grep -q vpn_${SE_NICNAME} /proc/net/dev; then 
      printf "NIC ${SE_NICNAME} already exists, skipping creation" 1>&2
    else
      vpncmd localhost /CLIENT /CMD NicCreate ${SE_NICNAME} 1>&2
    fi
      
    vpncmd localhost /CLIENT /CMD AccountCreate ${SE_ACCOUNT_NAME} /SERVER:${SE_SERVER} /HUB:${SE_HUB} /USERNAME:${SE_USERNAME} /NICNAME:${SE_NICNAME} 1>&2
    vpncmd localhost /CLIENT /CMD AccountPasswordSet ${SE_ACCOUNT_NAME} /PASSWORD:${SE_PASSWORD} /TYPE:${SE_TYPE} 1>&2
    vpncmd localhost /CLIENT /CMD AccountConnect ${SE_ACCOUNT_NAME} 1>&2

    udhcpc -i vpn_${SE_NICNAME} -n -q -f 1>&2
    
    printf "RESULT 2\nOK"
    
    printf "Configuration done" 1>&2
  done
done
