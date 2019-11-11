#!/bin/bash
wget -O - -q http://geoip.ubuntu.com/lookup | sed -n -e 's/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p' | sudo tee /etc/timezone 
sudo emerge --config sys-libs/timezone-data
