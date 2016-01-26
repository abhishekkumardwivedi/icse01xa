#!/bin/sh

ICSE_DEV="/dev/ttyUSB0"
ICSE_DEVID=50
ICSE_BEGIN=51
ICSE_CLR0=ff
ICSE_CLR1=00

icse_write() {
    echo -e -n "\x"$1 > $ICSE_DEV
}

icse_setup() {
    echo "root permission to grant read/write permisssion to usb device ..."
    sudo chmod 777 $ICSE_DEV
    #use libudevadm to get device details and confirm
    icse_write $ICSE_DEVID
    icse_write $ICSE_BEGIN
    icse_write $ICSE_CLR0
    icse_write $ICSE_CLR1
}

icse_operate() {
 # check for channels available for the device
 icse_write $1
}

echo " ------------------------------"
echo " Write channel inputs to turn relay on."
echo " input should be in bitwise:"
echo " 1=>1, 2=>2, 4=>3, 8=>4, 3=>1+2, etc"
echo "--------------------------------"

while true
    do
       read -p "Channels:" channel
        icse_operate $channel
done
