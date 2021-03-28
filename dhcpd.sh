#!/bin/bash
#dhcpd.sh Adrià Jara
if (( EUID != 0 ))
	then
		echo "El script ha de ser executat per root"
		exit 1 
fi
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.$(date +20%y%m%d%H%M)
echo -n "Nom del domini: "
read domini
echo -n "IP del servidor DNS: "
read dns
echo -n "IP del Router: "
read router
echo -n "Temps de leasing: "
read leasing
echo -n "Max del temps de leasing: "
read leasing_max
echo -n "IP de la subxarxa: "
read subxarxa
echo -n "Mascara de subxarxa: "
read msc_sub
echo -n "Primera IP del rang: "
read prang
echo -n "Darrera IP del rang: "
read drang
echo "authoritative;" > /etc/dhcp/dhcpd.conf
echo "ddns-update-style none;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name $domini;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers $dns;" >> /etc/dhcp/dhcpd.conf
echo "option routers $router;" >> /etc/dhcp/dhcpd.conf
echo "default-lease-time $leasing;" >> /etc/dhcp/dhcpd.conf
echo "max-lease-time $leasing_max;" >> /etc/dhcp/dhcpd.conf
echo "subnet $subxarxa netmask $msc_sub { " >> /etc/dhcp/dhcpd.conf
echo "range $prang $drang;" >> /etc/dhcp/dhcpd.conf
echo "}" >> /etc/dhcp/dhcpd.conf
systemctl restart isc-dhcp-server 2> /dev/null
exit 0
