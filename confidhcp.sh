# configuracion dhcp
# sh configuradhcp.sh red máscara ipinicial ipfinal dns nombre gateway tarjetadered

if [ $# -ne 8 ]; then
	echo "Error en parámetros"
	echo "sh configuradhcp.sh red máscara ipinicial ipfinal dns nombre gateway tarjetadered"
	exit 1
fi

echo "ddns-update-style none;" > dhcp
echo "subnet $1 netmask $2 {" >> dhcp
echo "range $3 $4;" >> dhcp
echo "option domain-name-servers $5;" >> dhcp
echo "option domain-name \"$6\";" >> dhcp
echo "option routers $7;" >> dhcp
echo "default-lease-time 600;" >> dhcp
echo "max-lease-time 7200;"  >> dhcp
echo "}" >> dhcp

read -p "Configurar dhcp (s) " op
if [ $op = "s" ]; then
	cp dhcp /etc/dhcp/dhcpd.conf
	echo "INTERFACESv4=\"$8\"" > /etc/default/isc-dhcp-server
	service isc-dhcp-server restart
	echo "configurado"
fi
exit 0
