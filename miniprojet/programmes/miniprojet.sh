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

UserAgent="PPE1-Script/1.0 (INALCO-SORBONNE-NOUVELLE-2025; projet pédagogique 2025)"

NUM_LIGNE=0


echo -e "NUM_LIGNE\tURL\tCode HTTP\tEncodage\tNb de mots"
echo "----------------------------------------------------------------------------"

#for URL in "$FICHIER" > boucle for utile si plusieurs fichiers
#do

	while read -r LINE; do
	[[ $LINE =~ ^https?:// ]] || continue

		HEADERS=$(curl -IL -s --max-time 15 -A "$UserAgent" "$LINE" | tr -d '\r')

		CODE_HTTP=$(echo "$HEADERS" | head -n 1 | awk '{print $2}')
		if [[ -z "$CODE_HTTP" ]]; then
				CODE_HTTP="None"
		fi

		if echo "$HEADERS" | grep -qi "charset=";then
			ENCODAGE=$(echo "$HEADERS" | grep -i "charset="| head -n 1| cut -d= -f2 | cut -d ';' -f1)
		else
			ENCODAGE="Pas d'encodage"
		fi

		CONTENU=$(curl -sL --compressed --max-time 30 -A "$UserAgent" "$LINE")
		NB_MOTS=$(wc -w <<< "$CONTENU" | awk '{print $1}')
		[[ -z "$NB_MOTS" ]] && NB_MOTS=0

		NUM_LIGNE=$(($NUM_LIGNE + 1))
		echo -e "ligne $NUM_LIGNE\t$LINE\t$CODE_HTTP\t$ENCODAGE\t$NB_MOTS"

	done < "$FICHIER"

#Si boucle for : done < "$URL"
#done


