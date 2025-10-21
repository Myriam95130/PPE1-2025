!/bin/bash

echo "Argument donné : $1"

CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"

if [[ ! -d $CHEMIN ]]; then
    echo "Erreur, le dossier $CHEMIN n'existe pas."
    exit 1
fi

echo "Nombre de lieux en 2016 :"
cat $CHEMIN/2016/*.ann | grep "Location" | wc -l 
echo "Nombre de lieux en 2017 :"
cat $CHEMIN/2017/*.ann | grep "Location" | wc -l
echo "Nombre de lieux en 2018 :"
cat $CHEMIN/2018/*.ann | grep "Location" | wc -l
