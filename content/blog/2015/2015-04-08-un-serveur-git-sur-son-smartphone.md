title=Installer un serveur GIT avec LinuxDeploy Debian
date=2015-04-08
type=post
tags=blog, android, serveur, git
status=published
~~~~~~

Après avoir installer LinuxDeploy sur son téléphone android comme vu dans le precedent [billet]({{ site.url }}/articles/Transformer-son-telephone-android-en-miniserver),
nous allons installer git et le configurer pour heberger nos developpement. Dans cette exemple deux utilisateurs seront créer git et gitadmin.
Git est l'utilisateur standard, pour utiliser les dépots. Gitadmin permet d'administrer les dépots.

## Installation
	sudo aptitude install git

### Ajout des utilisateurs et groupe
	sudo groupadd gitusers
	sudo useradd -g gitusers -s /usr/bin/git-shell git
	sudo useradd -g gitusers -s /usr/bin/git-shell gitadmin
	sudo mkdir /opt/git/
	sudo chown gitadmin:gitusers /opt/git/
	
### git-shell-command
Pour securiser le shell les utilisateurs git et gitadmin utilise git-shell. 
Ce shell permet de limiter les actions à celle definis dans le repertoire git-shell-commands.
Dans cette exemple les commande disponnible permettent d'ajouter des clef ssh, de créer un repository de lister les repository existant.

	sudo git clone https://gist.github.com/fad3b78b359153bd36c9.git /opt/git/git-shell-commands
	sudo chown -R gitadmin:gitusers /opt/git/git-shell-commands/
	sudo chmod -R +x /opt/git/git-shell-commands
	sudo ln -s /opt/git/git-shell-commands /home/git/git-shell-commands
	sudo ln -s /opt/git/git-shell-commands /home/gitadmin/git-shell-commands
	
	
## Fichiers git-shell

{% gist fad3b78b359153bd36c9 %}


