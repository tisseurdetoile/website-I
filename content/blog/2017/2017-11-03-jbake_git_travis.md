title=Pour un blog static facile avec JBAKE + GIT + TRAVISCI
date=2017-11-03
type=post
tags=jbake, travisci, git
status=published
~~~~~~

Un blog statique c'est cool, moins de problème de sécurité, une vitesse de rendu sans pareil, n'importe qu'elle hebergeur peux faire l'affaire. Mais c'est aussi dire bonjour à une mise plus fastidieuse à coup de ftp. Pour rendre tout cela fluide le triptyque JBake + Git + TravisCi est une des solution.

## Ce qu'il faut
* Un repository GIT publique. (comme https://github.com/tisseurdetoile/jbake-uno)
* Les identifiants FTP de votre site web ainsi que le chemin attendus des fichiers.
* configurer travisCI

## Comment faire
* forker mon template jbake-uno
	![travisCi Environnement variable](https://framapic.org/CbHEY7VEW1rO/FusAcIV23yGM.png)
* cloner ce nouveau repository sur votre poste
	* ```git clone git@github.com:<yourName>/jbake-uno.git```
* commencer à écrire votre blog
	* modifier jbake.properties pour le configurer à vos besoin.
	* créer/editer les fichier dans content/blog/YYYY/YYYY-MM-JJ-name.md	
* faite vos tests
	* ```jbake -b```
	* ```jbake -s```
* configurer travisCI
	![travisCi Environnement variable](https://framapic.org/jDO2lNuVVUn0/J6yhAIdTbQBv.png)
	* HOST contient le nom de l'hôte ftp
	* USER contient le nom de l'utilisateur ftp
	* PASS contient le mot de passe de l'utilisateur ftp
	* SITE_PATH contient le chemin depuis la racine ou uploader les fichiers
* "comiter" sur master
	* ```git add content/blog/```
	* ```git commit -m "message"```
	* ```git push```
* surveiller le build travisCI
* regarder sur votre site web 

## S'inspirer
vous pouvez regarder le fichier .travis.yml pour la configuration de travisCi et aussi le fichier scripts/travis_build