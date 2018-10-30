title=Prise en charge d'un onduleur avec QNAP et raspbery PI
date=2015-04-23
type=post
tags=article, qnap, serveur, raspberry, nut
status=published
~~~~~~

## Préambule

Avec plusieur raspberry pi, un NAS QNAP 219 le tout branché sur un onduler APC 500
voilà une bonne raison pour installer la gestion en réseau de l'onduleur avec NUT. 
A noter que le NAS ne peut être le poste Serveur Nut, car il n'est pas constament allumé.

Le serveur Nut est un raspberryPi avec pour ip 192.168.0.9


## Installation du serveur
	# sudo apt-get install nut

### Detection de l'onduleur
	# lsub
	Bus 001 Device 004: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
	# dmesg  | grep UPS 
	usb 1-1.3: Product: Back-UPS CS 500 FW:808.q10 .I USB FW:q10 
	hid-generic 0003:051D:0002.0001: hiddev0,hidraw0: USB HID v1.10 ...

L'onduleur est accèsible dans hidraw0


###  /etc/udev/rules.d/99_nut-serialups.rules
	# sudo nano /etc/udev/rules.d/99_nut-serialups.rules

	KERNEL=="hidraw0", GROUP="nut"

	# sudo udevadm trigger
	# sudo udevadm control --reload-rules

### nut.conf
	# sudo nano /etc/nut/nut.conf

	MODE=netserver

### ups.conf
	# sudo nano /etc/nut/nut.conf

	[qnapups]
		driver = usbhid-ups
		port = /dev/hidraw0
		desc = "Server"

### upsd.conf
	#sudo nano /etc/nut/nut.conf

	LISTEN 127.0.0.1
	LISTEN 192.168.0.9

### configuration des utilisateurs
	# sudo nano /etc/nut/upsd.user

	[nut]
	password = nut
	allowfrom = localhost lan
	upsmon master
	actions = SET
	instcmds = ALL

	[admin]
	password = 123456
	allowfrom = localhost lan
	actions = SET
	instcmds = ALL
	upsmon slave           # or upsmon slave


### /etc/nut/upsmon.conf
	# sudo nano /etc/nut/upsmon.conf

	MONITOR qnapups@localhost 1 nut nut master

## Configuration des clients
	sudo apt-get install nut-client
### nut.conf
	# sudo nano /etc/nut/nut.conf
	
	MODE=netclient

### upsmon.conf
	# sudo nano /etc/nut/nut.conf

	MONITOR qnapups@192.168.0.9 1 admin 123456 slave

### Specificité pour qnap
En regardant la config du NAS Qnap en mode esclave seul l'ip du serveur est configurable. Le reste est stocké en dur. L'onduleur doit être identifié par le nom qnapups, l'utilisateur qui fera les requete est admin avec pour mot de passe 123456. Par defaut d'ailleur admin accede à toute la configuration.
Pour configurer l'onduleur sur le NAS : aller dans Dispositif Externe > UPS / ASI
Choisissez dispositif externe et specifier l'adresse du serveur ici 192.168.0.9

## bonus suivie des données dans domoticz
Ayant un raspberryPi faisant tournée domoticz il me parraissait pertinent de recuperer les informations
de l'onduleur charge, niveau de batterie et temperature pour les afficher dans domoticz.

- tout d'abord il faut creer trois capteur virtuel et noter leur ID
    - charge en pourcentage
    - niveau de batterie en pourcentage
    - temperature 

## bbliographie 
http://abakalidis.blogspot.fr/2013/04/using-raspberry-pi-as-ups-server-with.html
