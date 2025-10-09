!/bin/bash

echo "Arguments donnés : $1, $2, $3"

CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"
NB_LIGNES16=$(cat $CHEMIN/2016/*.ann | grep -E "Location|Person|Organization" | wc -l)

echo "Nombre de lieux, de personnes et d'organisations en 2016 : "

echo "$NB_LIGNES16"

NB_LIGNES17=$(cat $CHEMIN/2017/*.ann | grep -E "Location|Person|Organization" | wc -l)

echo "Nombre de lieux, de personnes et d'organisations en 2017 : "

echo "$NB_LIGNES17"

NB_LIGNES18=$(cat $CHEMIN/2018/*.ann | grep -E "Location|Person|Organization" | wc -l)

echo "Nombre de lieux, de personnes et d'organisations en 2018 : "
echo "$NB_LIGNES18"
