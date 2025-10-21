#!/bin/bash

CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"

if [[ ! -d "$CHEMIN" ]]; then
    echo "Erreur, le dossier $CHEMIN n'existe pas."
    exit 1
fi


for ANNEE in 2016 2017 2018
do
    echo "Année : $ANNEE"

if [[ ! -d "$CHEMIN/$ANNEE" ]]; then
    echo "Erreur, les dossiers $CHEMIN/$ANNEE n'existent pas"
    continue
fi

for f in "$CHEMIN/$ANNEE/"*.ann; do
    if [[ "$f" == "$CHEMIN/$ANNEE/"*.ann ]]; then
        echo "Aucun fichier .ann trouvé dans $ANNEE."
        break
    fi

    if [[ -f "$f" && "$f" == *.ann ]]; then
        echo "$f est un fichier .ann valide"
    else
        echo "$f n'est pas un fichier .ann"
    fi
done

    echo "Location : $(grep -E 'Location' "$CHEMIN/$ANNEE/"*.ann | wc -l)"
    echo "Person : $(grep -E 'Person' "$CHEMIN/$ANNEE/"*.ann| wc -l) "
    echo "Organization : $(grep -E 'Organization' "$CHEMIN/$ANNEE/"*.ann | wc -l)"
done











#CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"

#echo "Le type d'argument : $1, $2, $3"

#TYPE1=$(cat $CHEMIN/2016/*.ann $CHEMIN/2017/*.ann $CHEMIN/2018/*.ann | grep -E "Location" | wc -l)

#echo "Le nombre de lieux par année : "
#echo "$TYPE1"

#TYPE2=$(cat $CHEMIN/2016/*.ann $CHEMIN/2017/*.ann $CHEMIN/2018/*.ann | grep -E "Person" | wc -l)

#echo "Le nombre de personnes par année : "
#echo "$TYPE2"

#TYPE3=$(cat $CHEMIN/2016/*.ann $CHEMIN/2017/*.ann $CHEMIN/2018/*.ann | grep -E "Organization" | wc -l)

#echo "Le nombre d'organisations par année : "
#echo "$TYPE3"
