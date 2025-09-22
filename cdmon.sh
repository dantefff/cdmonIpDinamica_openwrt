#!/bin/ash
USER=your_user_here
PASSMD5=md5_of_your_password_here
HOST=domain_to_update.com
IP_DNS_ONLINE=$(host $HOST dinamic1.cdmon.net | grep -m1 $HOST | awk {'print $4'})
IP_ACTUAL=$(wget -q -O- http://ipecho.net/plain)
if [ "$IP_ACTUAL" ]; then
    if [ "$IP_DNS_ONLINE" != "$IP_ACTUAL" ]; then
        CHANGE_IP="https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=$USER&p=$PASSMD5"
        RESULT=`wget $CHANGE_IP -o /dev/null -O /dev/stdout --no-check-certificate`
        echo "$(date) #### The IP change was triggered in the dynamic dns cdmon server from $IP_DNS_ONLINE to $IP_ACTUAL. Result was: $RESULT" | logger -t "DYNDNS-CDMON" -p 6 
# uncomment next two lines see debug messages with logread when no ip change is done
#    else 
#        echo "$(date) #### Online ip and actual ip are the same ($IP_DNS_ONLINE). No call to cdmon was triggered" | logger -t "DYNDNS-CDMON" -p 7
    fi
fi
