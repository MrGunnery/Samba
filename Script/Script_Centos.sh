#!/bin/bash
fichier=$1

while read ligne
	do 
		login=$(echo $ligne | cut -d: -f1)
		mdp=$(echo $ligne | cut -d: -f2)
		group=$(echo $ligne | cut -d: -f3)
		echo "Création de l'utilisateur "$login
		adduser $login  -g $group
		echo -e "$mdp\n$mdp" | (smbpasswd -a -s $login)
		mkdir /profiles/$login
		mkdir /profiles/$login.V2
		chmod 700 /profiles/$login
		chmod 700 /profiles/$login.V2
		chown $login:$group /profiles/$login
		chown $login:$group /profiles/$login.V2
	done < $fichier
exit 0
