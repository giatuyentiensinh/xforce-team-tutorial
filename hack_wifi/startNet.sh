# changer wlan0 mode monitor
ifconfig wlan0 down
iwconfig wlan0 mode monitor
ifconfig wlan0 up

# start mon0 and change mon0 mode monitor
airmon-ng start wlan0
ifconfig mon0 down
iwconfig mon0 mode monitor
ifconfig mon0 up

# start mon1
airmon-ng start mon0


