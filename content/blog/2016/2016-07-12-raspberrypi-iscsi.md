title=ISCSI root avec un raspberry PI.
date=2016-07-12
type=post
tags=iscsi, raspberry, howto
status=published
~~~~~~

Pour palier au problème d'usure des cartes SD j'utilisais [berryBoot](http://www.berryterminal.com/doku.php/berryboot) pour installer linux sur un LUN iscsi. Mais cette solution quoi que pratique ne supporte pas très bien les mises à jour du noyau. Depuis quelques temps raspbian supporte de façon native le iscsi. voici comment installer raspbian avec iscsi.

## Informations
### Configuration
Client : Raspberry PI2 / Raspbian jessy lite V4.4 / 2016-05-27 sur Sdcard 4Go Samsung
Serveur iscsi : QNAP TS-131 / adresse ip 192.168.0.10
Box Internet : serveur DHCP

### Prérequis
La machine cliente sera l'initiateur et devra avoir un nom d'initiateur icsci dont le format est le suivant iqn.yyyy-mm.naming-authority:unique il doit être unique sur le réseau. dans cet exemple le nom sera iqn.2012-07.org.raspbian:raspberry:local.home.raspbian. Le nom de la cible sera définis au niveau du NAS dans cette exemple se sera iqn.2004-04.com.qnap:ts-131:iscsi.raspbian.e65bfb.

## Installation
### Préparer le disque iscsi
Il suffit de créer une cible(target) iscsi avec son volume (LUN) en suivant la
[Documentation QNAP](https://www.qnap.com/i/en/tutorial/con_show.php?op=showone&cid=29)

### Installer raspbian lite
J'utilise une raspbian lite disponible [ici](https://www.raspberrypi.org/downloads/raspbian/) documentation d'installation [là](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)
Mettre la sdcard dans le raspberry pi et mettez le sous tension.
connecter vous avec l'utilisateur pi mot de passe raspberry
exécuter les commandes suivantes :
1. `sudo aptitude update`
2. `sudo aptitude upgrade`
3. `sudo aptitude install rsync open-iscsi`
4. `sudo reboot`

### Finaliser l'installation iscsi
reconnecter vous avec l'utilisateur pi
1. `sudo nano /etc/iscsi/initiatorname.iscsi` mettre la valeur iqn.2012-07.org.raspbian:raspberry:local.home.raspbian
2. `sudo /etc/init.d/open-iscsi start`
3. `sudo systemctl daemon-reload`
4. `sudo iscsiadm --mode discovery --type sendtargets --portal 192.168.0.10:3260`
	résultat : 192.168.0.10:3260,1 iqn.2004-04.com.qnap:ts-131:iscsi.raspbian.e65bfb
5. `sudo iscsiadm -m node --targetname "iqn.2004-04.com.qnap:ts-131:iscsi.raspbian.e65bfb" --portal "192.168.0.10:3260" --login`
6. `sudo mkfs.ext4 -m0 /dev/sda`
7. `sudo mkdir /mnt/iscsi && sudo mount /dev/sda /mnt/iscsi`
8. `sudo rsync -avhP --exclude /boot --exclude /proc --exclude /sys --exclude /mnt / /mnt/iscsi/ `
9. `sudo mkdir /mnt/iscsi/{proc,sys,boot,initrd,mnt}`
10. `sudo touch /etc/iscsi/iscsi.initramfs`  (nécessaire à update-initramfs)
11. `sudo touch /mnt/iscsi/etc/iscsi/iscsi.initramfs`  
12. ```sudo update-initramfs -c -k `uname -r` ```
	résultat : update-initramfs: Generating /boot/initrd.img-4.4.13-v7
13. `sudo cp /boot/kernel7.img /boot/kernel7-4.4.13-v7+.img`
14. `sudo nano /boot/config.txt`
	ajouter : 
		kernel=kernel7-4.4.13-v7+.img
		initramfs initrd.img-4.4.13-v7+ followkernel
15. `sudo blkid /dev/sda`
	résultat : /dev/sda: UUID="b042d66d-ead3-4742-953a-61e2bf162aaf" TYPE="ext4"
16. `sudo nano /boot/cmdline.txt`
	ip=::::raspberrypi:eth0:dhcp ISCSI_INITIATOR=iqn.2012-07.org.raspbian:raspberry:local.home.raspbian ISCSI_TARGET_NAME=iqn.2004-04.com.qnap:ts-131:iscsi.raspbian.e65bfb ISCSI_TARGET_IP=192.168.0.10 ISCSI_TARGET_PORT=3260 dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=UUID=b042d66d-ead3-4742-953a-61e2bf162aaf rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait

#### Nota
Les étapes 7, 8 et 9 permettent de copier l'installation vers le fileSystem iscsi.
Les étapes 10,11,12 et 13 assure que le noyau et les modules ne changent pas après une mise à jour.
L'étape 15 configure la connexion vers la cible iscsi.

### Conclusion
voilà vous n'avez plus qu'a faire rebooter, vous verrez votre pi récupérer une adresse ip puis monter le disque iscsi et continuer le démarrage.
Vous pouvez donc cloner une installation complète comme ceci :
- sauvegarder le LUN de cette installation, le copier vers un nouveau LUN associé à une nouvelle cible
- copier le contenu de la sdcard sur une nouvelle éditer le fichier /boot/cmdline.txt
- changer les paramètres suivant pour qu'il corresponde à cette nouvelle cible n'oublier pas de changer le nom de l'initiateur :
ISCSI_INITIATOR=iqn.2012-07.org.raspbian:raspberry:local.home.raspbian ISCSI_TARGET_NAME=iqn.2004-04.com.qnap:ts-131:iscsi.raspbian.e65bfb ISCSI_TARGET_IP=192.168.0.10 ISCSI_TARGET_PORT=3260



## Bibliographie :
source :
1. https://www.reddit.com/r/raspberry_pi/comments/49l25b/iscsi_booting_your_raspberry_pi/
2. https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=151302

## Changelog
2016-07-14 : correction de coquille dans les commandes.
