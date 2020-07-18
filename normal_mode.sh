BASEDIR=$(dirname "$0")

sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

echo "Stopping hostapd & dnsmasq services..."
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

echo "Remove bridge configuration"
sudo rm /etc/network/interfaces.d/br0

echo "Revert DHCPCD configuration"
sudo cp $BASEDIR/bak/dhcpcd.conf /etc/dhcpcd.conf


sudo cp $BASEDIR/bak/wpa_supplicant.conf /etc/wpa_supplicant/

echo "Done, rebooting"
sudo reboot
