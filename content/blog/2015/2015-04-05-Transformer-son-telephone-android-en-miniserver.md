title=Transformer son smartphone en serveur Android/nix
date=2015-04-05
type=post
tags=blog, android, serveur
status=published
~~~~~~

Parfois il peut s'averer utile d'avoir un mini serveur sur soi pour montrer un prototype de site web ou application web, ou encore avoir un serveur GIT dans la poche.

Il est tout à fait possible d'utiliser son "smartphone" pour cela. Un téléphone sous android 2.1 minimum, une sdcard de quelques Giga (en fat un fichier ne peu depasser les 4Go le système est stocké dans un fichier) et une bonne connexion internet, L'application LinuxDeploy et le tour et joué.
Linux Deploy n'est pas une solution de virtualisation c'est un chroot du sysème android vers une distribution particulière. Linux Deploy propose pas mal de distribution (Debian, Gentoo, etc ...). Ici j'utiliserais Debian comme distribution de réference.

## Installation
Il faut installer [SuperSu](#.2) et [LinuxDeploy](#.1) sur le téléphone, en demarrant LinuxDeploy vous devez choisir la destination du fichier image "/storage/extSdCard/monimage.img" la distribution le système de fichier et la taille de l'image. Pour ma part j'utilise Other comme "DesktopEnvironnement" car je n'utilise que la console. Revener sur clique sur install pour demarrer l'installation. 

## Ensuite
Pour quoi pas installer : 

* un serveur web (nginx, php, sqlite) à voir bientôt.
* un serveur git à lire [ici]({{ site.url }}/articles/un-serveur-git-sur-son-smartphone)

## Astuce
Si comme moi vous avez commencer à travailler avec une image trop petite 2Go voici l'astuce pour copier les données d'une image fichier à une autre.

	# sudo mkdir /mnt/source
	# sudo mkdir /mnt/destination
	# sudo mount -o loop /tmp/imageorig.img /mnt/source
	# sudo mount -o loop /tmp/imagedest.img /mnt/destination
	# sudo cp -a /mnt/mnt/source/* /mnt/destination
	
Le fichier "imagedest.img" contient maintenant les données de "imageorig.img"


## Bibliographie
* <a id=".1"></a>1. Linux Deploy [PlayStore][PlayStoreLinuxDeploy]
* <a id=".2"></a>2. Linux Deploy [GitHub][GitHub]
* <a id=".3"></a>3. Linux Deploy [Blog RU][Blog RU]
* <a id=".4"></a>4. SuperSu [PlayStore][PlayStoreSuperSu]
* <a id=".5"></a>5. Autre tuto sur l'installation de LinuxDeploy chez [Korben][Korben]

[PlayStoreLinuxDeploy]: https://play.google.com/store/apps/details?id=ru.meefik.linuxdeploy&hl=fr_FR]
[GitHub]: https://github.com/meefik/linuxdeploy
[Blog RU]: http://meefik.ru/blog/categories/linuxdeploy/
[PlayStoreSuperSu]: https://play.google.com/store/apps/details?id=eu.chainfire.supersu
[Korben]: http://korben.info/comment-installer-linux-sur-android.html