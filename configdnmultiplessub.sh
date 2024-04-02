#!/bin/bash
#Configuración dns con multiples subdominios
if [ $# -lt 7 ]; then
	echo "Error en parámetros"
	echo "sh confidns.sh zona nombreservidor enamil nserie ipserver subdominio ip [subdominio2 ip2 ...]"
	exit 1
fi	


# named.conf.local
echo "" > zone
echo "zone \"$1\" {" >> zone
echo "type master;" >> zone
echo "file \"/etc/bind/rd.$1\";" >> zone
echo "};" >> zone



  
echo "\$TTL 38400" > "rd.$1"
echo " " >> "rd.$1"
echo "@	IN	SOA	$2.$1. $3. (" >> "rd.$1"
echo "        $4" >> "rd.$1"
echo "	28800" >> "rd.$1"
echo "	3600" >> "rd.$1"
echo "	604800" >> "rd.$1"
echo "	38400 )" >> "rd.$1"

echo "@ IN NS $2.$1." >> "rd.$1"


echo "$2.$1. IN A $5" >> "rd.$1"

# variable booleana para controlar el principio de la línea IN A
lineaNueva=1
#perdemos los primeros 5 parametros, guardamos la zona 
zona=$1
shift 5 # Descartamos los primeros cinco parámetros
for param in "$@"; do
	if [ $lineaNueva -eq 1 ]; then
		linea="$param.$zona. IN A "
		export linea  #para poder acceder a su valor en el else
		lineaNueva=0
	else
	
	        linea="$linea $param"
	        lineaNueva=1
	        echo "$linea" >> "rd.$zona"
	fi        
	          
done



read -p "Configurar dhcp (s) " op
if [ $op = "s" ]; then
	cp "rd.$zona" /etc/bind/
	cat zone >> /etc/bind/named.conf.local
	service bind9 restart
	echo "configurado"
fi
exit 0
