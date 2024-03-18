if [ $# -ne 5 ]; then
	echo "Error en parámetros"
	echo "sh ipfija.sh interface ip máscara gateway dns"
	exit 1
fi
echo "source /etc/network/interfaces.d/*" > interfacesi
echo 
echo "auto lo" >> interfacesi
echo "iface lo inet loopback" >> interfacesi
echo
echo "auto $1" >> interfacesi
echo "iface $1 inet static" >> interfacesi
echo "address $2" >> interfacesi
echo "netmask $3" >> interfacesi
echo "gateway $4" >> interfacesi
echo "dns-nameservers  $5" >> interfacesi
read -p "Configurar ip $2 (s)" op
if [ $op = "s" ]; then
	cp interfacesi /etc/network/interfaces
	echo "ip $2 Configurada"
fi
rm interfacesi
exit 0
