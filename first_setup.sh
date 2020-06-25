BASEDIR=$(dirname "$0")

echo "apt update..."
sudo apt-get -y update
echo "apt upgrade..."
sudo apt-get -y upgrade

echo "apt install hostapd dnsmasq..."
sudo apt-get -y install hostapd
sudo apt-get -y install dnsmasq

sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

echo "Configure hostapd & dnsmasq..."
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo cp ${BASEDIR}/hotspot-conf/dnsmasq.conf /etc/dnsmasq.conf

sudo cp ${BASEDIR}/hotspot-conf/hostapd.conf  /etc/hostapd/hostapd.conf
sudo cp ${BASEDIR}/hotspot-conf/hostapd /etc/default/hostapd

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

echo "dhcpcd.conf..."
cp /etc/dhcpcd.conf ${BASEDIR}/bak/
cp ${BASEDIR}/bak/dhcpcd.conf ${BASEDIR}/hotspot-conf/

isconfigured=`grep "#hotspot_config_flag" ${BASEDIR}/hotspot-conf/dhcpcd.conf | wc -l`
if [ ${isconfigured} -eq 0 ]
then
    echo "add new DHCPCD configuration..."
    cat $BASEDIR/hotspot-conf/dhcpcd.ap.conf >> $BASEDIR/hotspot-conf/dhcpcd.conf
fi
