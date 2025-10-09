#!/bin/bash
ANNEE="$1"
MOIS="$2"
NB="$3"

echo "Classement des lieux les plus cités par mois et années : $ANNEE, $MOIS, $NB"

CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"

COMPTER_LOC=$(cat "$CHEMIN"/$ANNEE/*_"$MOIS"*.ann | grep -E "Location" |cut -f3 | sort | uniq -c | sort -nr | head -n "$NB")



echo "Le classement est le suivant :"
echo "$COMPTER_LOC"
