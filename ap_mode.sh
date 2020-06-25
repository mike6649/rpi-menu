BASEDIR=$(dirname "$0")

sudo systemctl enable hostapd
sudo systemctl enable dnsmasq

echo "Stopping hostapd & dnsmasq services..."
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

echo "Applying IP Forwarding and Masquerading..."
sudo cp $BASEDIR/hotspot-conf/sysctl.conf /etc/sysctl.conf
sudo cp $BASEDIR/hotspot-conf/rc.local /etc/rc.local

echo "Adding bridge configuration..."
sudo cp $BASEDIR/hotspot-conf/br0 /etc/network/interfaces.d/
echo "Updated DHCPCD configuration..."
sudo cp $BASEDIR/hotspot-conf/dhcpcd.conf /etc/dhcpcd.conf

echo "Adding br0 bridge..."
sudo brctl addbr br0
echo "The machine will reboot now."
sudo brctl addif br0 eth0
sudo reboot
