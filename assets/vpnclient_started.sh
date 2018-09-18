#!/bin/sh
set -e

while true
do
  printf "READY\n"

  while read line
  do
    printf "$line" 1>&2
  
    vpncmd localhost /CLIENT /CMD NicCreate ${SE_NICNAME} 1> /dev/null
    vpncmd localhost /CLIENT /CMD AccountCreate ${SE_ACCOUNT_NAME} /SERVER:${SE_SERVER} /HUB:${SE_HUB} /USERNAME:${SE_USERNAME} /NICNAME:${SE_NICNAME} 1> /dev/null
    vpncmd localhost /CLIENT /CMD AccountPasswordSet ${SE_ACCOUNT_NAME} /PASSWORD:${SE_PASSWORD} /TYPE:${SE_TYPE} 1> /dev/null
    vpncmd localhost /CLIENT /CMD AccountConnect ${SE_ACCOUNT_NAME} 1> /dev/null

    udhcpc -i vpn_${SE_NICNAME} 1> /dev/null
    
    printf "RESULT 2\nOK"
  done
done
