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

#for URL in "$FICHIER" > boucle for utile si plusieurs fichiers
#do

OUT="miniprojet.html"

echo -e "<!DOCTYPE html>
<html lang='fr'>
<head>
<meta charset='UTF-8'>
<title>Résultats</title>
</head>
<body>
<table>
<tr><th>NUM_LIGNE</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Nb de mots</th></tr>" > "$OUT"

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
		echo -e "<tr><td>$NUM_LIGNE</td><td>$LINE</td><td>$CODE_HTTP</td><td>$ENCODAGE</td><td>$NB_MOTS</td></tr>" >> "$OUT"
	done < "$FICHIER"

	echo -e "</table>
	</body>
	</html>" >> "$OUT"

#Si boucle for : done < "$URL"
#done


