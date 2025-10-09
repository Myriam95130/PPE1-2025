#!/bin/bash

CHEMIN="$HOME/PPE1-2025/Exercices/LECTURE"

# syntaxe spéciale de Bash qui permet de donner des valeurs par défaut aux variables quand les arguments $1, $2, $3 ne sont pas fournis.

ANNEE="${1:-*}" # “Si $1 est vide ou non défini, mets * à la place.”
MOIS="${2:-*}"
NB="${3:-10}"

echo "Année, Mois et Nombre de lieux : $ANNEE, $MOIS, $NB"

CLASSEMENT=$( cat "$CHEMIN"/$ANNEE/*_$MOIS*.ann | grep -E "Location" | cut -f3 | sort | uniq -c | sort -nr)

echo "Classement des lieux les plus cités pour $ANNEE/$MOIS : "
echo "$CLASSEMENT" | head -n "$NB"
echo

# $1 = année
# $2 = mois
# $3 = nombre de lieux

# La ligne : grep -E "Location" => garde seulement les lignes contenant le mot Location

#awk 'print{print $3}' => extrait la 3e colonne (le nom du lieu) présentée ainsi : T1	Location	Paris

#| awk '{print $3}' | sort | uniq -c | sort -nr

#sort permet de trier des lieux par ordre alphabétique

#uniq compte que les lignes identiques consécutives

#uniq sans option supprime les lignes consécutives identiques d'un texte

#uniq avec l'option -c (count) compte le nombre d'occurrences de chaque ligne identique (après tri)

#uniq avec l'option -d (duplicate) affiche uniquement les lignes dupliquées (présentes au moins deux fois)

#uniq avec l'option -u affiche uniquement les lignes uniques

#sort -n (number) trie les résultat numériquement et inverse l'ordre -r (reverse) => trie du plus cité au moins cité (décroissant)

# sort -k2 trie selon la deuxième colonne d'un fichier (par défaut, les colonnes sont séparées par des espaces ou tabulations)

# sort -f ignore la casse (Paris = paris)

# sort -u trie et supprime les doublons

# pipes : commande1 | commande2 | commande3
#prends le résultat de la commande1 puis l'envoie dans commande2 puis prends le résultat de commande2 et l'envoie dans commande3.

