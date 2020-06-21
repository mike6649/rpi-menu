BASEDIR=$(dirname "$0")

sudo systemctl enable hostapd
sudo systemctl enable dnsmasq

echo "Stopping hostapd & dnsmasq services..."
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

echo "Applying new dhcpcd.conf..."
sudo cp /etc/dhcpcd.conf $BASEDIR/bak/dhcpcd.conf
sudo cp $BASEDIR/hotspot-conf/dhcpcd.conf /etc/dhcpcd.conf
