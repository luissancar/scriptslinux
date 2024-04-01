if [ $# -lt 7 ]; then
	echo "Error en parámetros"
	echo "sh confidns.sh zona nombreservidor enamil nserie ipserver subdominio ip ..."
	exit 1
fi	  
echo "\$TTL 38400" > "rd.$1"
echo " " >> "rd.$1"
echo "@	IN	SOA	$2.$1. $3. (" >> "rd.$1"
echo "$4" >> "rd.$1"
echo "	28800" >> "rd.$1"
echo "	3600" >> "rd.$1"
echo "	604800" >> "rd.$1"
echo "	38400 )" >> "rd.$1"

echo "@ IN NS $2.$1." >> "rd.$1"
echo "$2.$1. IN A $5" >> "rd.$1"
echo "$6.$1. IN A $7" >> "rd.$1"


# named.conf.local
echo "" > zone
echo "zone \"$1\" {" >> zone
echo "type master;" >> zone
echo "file \"/etc/bind/rd.$1\";" >> zone
echo "};" >> zone

read -p "Configurar dhcp (s) " op
if [ $op = "s" ]; then
	cp "rd.$1" /etc/bind/
	cat zone >> /etc/bind/named.conf.local
	service bind9 restart
	echo "configurado"
fi
exit 0
