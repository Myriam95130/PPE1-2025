#!/bin/bash

#CHEMIN = $HOME/PPE1-2526/miniprojet/urls/*.fr

if [[ $# -ne 1 ]]; then

		echo "Erreur, aucun argument fourni"
	exit 1
fi

FICHIER=$1

if [[ ! -r "$FICHIER" ]]; then
	echo "Erreur, fichier introuvable"
	exit 1
fi

NUM_LIGNE=0


echo -e "URL\t\tCode HTTP\t\t\t\tEncodage\t\tNb de mots"
echo "----------------------------------------------------------------------------"

#for URL in "$FICHIER" > boucle for utile si plusieurs fichiers
#do

	while read -r LINE;
	do
		if [[ $LINE =~ ^https?:// ]]
		then
			HEADERS=$(curl -I -s --max-time 15 "$LINE")

			CODE_HTTP=$(echo "$HEADERS" | head -n 1 | awk '{print $2}')

			if echo "$HEADERS" | grep -qi "charset=";then
				ENCODAGE=$(echo "$HEADERS" | grep -i "charset=" | head -n 1| cut -d= -f2 | cut -d ';' -f1)
			else
				ENCODAGE="Pas d'encodage"
			fi

		NUM_LIGNE=$(($NUM_LIGNE + 1))
		CONTENU=$(curl -s --max-time 30 "$LINE")
		NB_MOTS=$(echo "$CONTENU" | wc -w)
		echo -e "ligne $NUM_LIGNE\t$LINE\t$CODE_HTTP\t$ENCODAGE\t$NB_MOTS"

		fi
	done < "$FICHIER"

#Si boucle for : done < "$URL"
#done


