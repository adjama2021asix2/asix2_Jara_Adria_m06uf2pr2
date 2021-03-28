#!/bin/bash
#mltpusr.sh Adrià Jara
if (( EUID != 0 ))
	then
		echo "El script ha de ser executat per root"
		exit 1 
fi
apt-get install pwgen
apt-get install whois  #poso aquest paquet perque algunes ordres el requereixen
echo -n "Num usuaris que es volen crear, màx 30: "
read numUs
if (( $numUs < 1 )) || (( $numUs > 30 ))
then
	echo "Error, no es poden crear més de 30 usuaris"
	exit 1
fi
echo -n "Plantilla per al nom del usuari: "
read nom
echo -n "UID Inicial: "
read uid
if (( $? != 0 ))
	then
		echo "Problema creant el fitxer d'usuaris i contrasenyes"
		exit 3
	fi
echo "Format de la llista: Nom d'usuari  Contrasenya  UID" >> /root/$nom 

for (( x=1; x<=$numUsr; x++ )) 
	do
	contra=$(pwgen 10 1)
	nomComplet=$nom$x.clot
	echo "$nomComplet  $contra  $uid" >> /root/$nom
	useradd $nom$x.clot -u $uid -g users -d /home/$nom$x.clot -m -s /bin/bash -p $(mkpasswd $contra)
	if (( $? != 0 ))
	then
		exit 2
	fi
	(( uid++ ))   
done 
exit 0
