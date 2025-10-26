# Journal de bord du projet encadré
## Mise en pratique de git

05/10/2025 : Aujourd'hui, j'ai appris à modifier mon journal de bord depuis ma machine au
lieu d'aller directement sur Github, grâce à la commande "nano" qui permet 
d'écrire dans le journal directement depuis le terminal. Il suffit de taper 
"nano" suivi du nom du fichier.

Cette commande me fait penser à une commande qui permet de modifier un fichier
directement dans le terminal et dont je m'étais servie dans un projet Bash
ultérieur. Il s'agit de "vim", dont la commande sortie est "wq". 

De ce que j'ai compris, la commande pull permet d'envoyer les modifications 
effectuées sur Github sur la amchine tandis que la commande "push" permet
d'envoyer les modifications effectuées sur la machine sur Github. Il est important de toujours penser à synchroniser les modifications.

J'aimerais ajouter un détail sur les étapes à suivre pour modifier le fichier :
1. Je suis entrée dans le dossier du projet PPE1-2025.
2. J'ai ouvert et modifier le journal avec la commande "nano".
3. J'ai rédigé (comme ici).
4. J'ai enregistré les changements avec "ctrl o".
5. J'ai vérifié sir git voit les changements à l'aide de "git status".
6. Il a répondu "modified: journal.md", donc c'est bon.
6. On dit à git de "préparer" le fichier grâce à "git add journal.md".
7. On revérifie de nouveau avec "git status" pour voir si le journal esr prêt à être enregistré, s'il est vert ça veut dire que oui.
8. On crée un "commit" aussi dit "enregistrement local" pour qu'il soit visible dans l'historique Git grâce à git commit -m "ma phrase" qu est une phrase d'enregistrement.
9. Git répondra quelque chose qui confirmera la sauvegarde locale.
10. On "push" les modifications sur Github "git push origin main" qu signifie "envoie mes commits locaux vers le déppôt GitHub, sur la branche main".
11. On refait git status et si on nous dit que "On branch main
Your branch is up to date with 'origin/main'.nothing to commit, working tree clean" c'est que tout est ok.

09/10/2025 : Aujoud'hui j'ai effectué les exercices pour m'entrainer aux Scripts Bash. L'exercice 1 ne m'a pas posé beaucoup de problème puisque j'ai déjà eu l'occasion de me familiariser au Shell et aux commandes Bash en licence TAL. L'exercice 2.a ne m'a pas posé beaucoup de problèmes si ce n'est au niveau des boucles, je connais la fonction d'une boucle, je saisbien les utiliser en Python et un peu moins en Python mais je pense avoir compris. Pour le script compte_par_type_par_an.sh, je comprenais les attentes mais je n'arrivais pas trop à visualiser clairement une structure, j'ai donc écrit et réecrit et à force, j'ai fini par un peu mieux saisir la logique du Bash. Cependant, l'exercice 2 m'a posé davantage de problèmes : j'ai compris l'énoncé mais je n'arrivais pas, encore une fois, à bien visualiser la structure attendue en Bash. Je me suis rendue compte que je ne faisais pas bien les pipelines, que parfois je passais des variables alors que ce sont des commandes qui étaient attendues. Je mettais parfois un | juste avant ou après une commande qui ne peut rien recevoir en entrée.
Exemple : $NB_LIEUX | cat ...

C'est une variable que Bash essaye d'exécuter comme un programme ce qui abouti à un "command not found" ou "permission denied".

Parfois je faisais le grep après le wc -l :

cat ... | wc -l | grep ...

wc -l ne renvoie qu'un chiffre, il n'y a plus rien à "grep" derrière donc il faut toujours faire : 
cat ... | grep ... | wc -l

=> il faut toujours filtrer grep et ensuite compter (wc -l)

Je faisais également des pipes sans cohérence de flux => je faisais cut puis wc -l puis awk, dans un ordre où la sortie ne correspondait plus à ce que la commande attend :

cut -f2 ... | wc -l | awk {print$3}

=> wc -l ne renvoie qu'un chiffre, donc awk n'a pas de 3e colonne à lire.
J'ai également compris que "cat" était une façon visuelle de dire "je prends ces fichiers et je les envoie dans la chaine".


cat $CHEMIN/2016/*.ann | grep "Location" | "Person" | "Organization" | wc -l

Je mettais parfois des pipes après des commandes qui ne produisent rien à lire :

NB_LIGNES=$(grep "$1|$2|$3" | wc -l $FICHIER)

=> Ici le grep n'a aucun fichier en entrée alors qu'il est suivi de wc -l > résultat ça ne lit rien donc $NB_LIGNES reste vide.
Il aurait fallu fairre ça :

NB_LIGNES=$(grep -E "$1|$2|$3" "$FICHIER" | wc -l)

Les pipes avant une variable :

$NB_LIEUX | cat ...
=> ici $NB_LIEUX est un nombre, pas une commande, Bash essaie de l'exécuter ce qui donne une erreur : command not found.

Enchainement de commandes qui ne se comprennent pas entre elles :

cut -f2 $CHEMIN/*.ann | wc -l | awk '{print $3}'

=> Le wc -l ne renvoie qu'un seul chiffre, awk '{print $3}' reçoit une ligne qui n'a pas de 3e colonne.

J'ai confondu sous-dossier et fichier. Je pensais que la ligne du dessous cherchait le nom d'un fichier :

CLASSEMENT=$($NB_LIEUX | cat "$CHEMIN"/$1/*_"$2*".ann | grep ...)

Ici Bash essayait d'exécuter ce qu'il y a dans $NB_LIEUX comme une commande puis de renvoyer la sortie dans cat (| cat ...)

=> Or $NB_LIEUX contenait un nombre, pas un nom de fichier ni une commande => Bash ne pouvait rien exécuter.

=> Le | cat "$CHEMIN"/$1/*_"$2*".ann supposait que $1 et $2 étaient des sous-dossiers ou des fichiers précis alors qu'en réalité $2 n'est qu'un motif (ex : "02" dans 2016_02_05-001.ann).

Résumé : 
- $NB_LIEUX n'est pas une commande
- $NB_LIEUX contient un nombre (résultat d'un comptage)
- Si on écrit $(...) Bash croit que l'on veut l'exécuter comme un programme.
=> par exemple s'il vaut 12, il va essayer d'exécuter un programme qui vaut 12 ce qi entraine un "command not found"
- Le | fait croire que je voulais envoyer la sortie de ce "programme" dans cat.

Je n'arrivais pas à exécuter mon script compte_lieux.sh, je ne comprenais pas pourquoi puis en fait, une syntaxe de Bash permet d'exécuter un programme même si l'utilisater oublie de mettre un argument :

Par exemple :
$1 = 2016
$2 = 02
$3 = 5

Mais Bash permet d'écrire : 

ANNEE="${1:-*}"
MOIS="${2:-*}"
NB="${3:-10}"

Je ne comprenais pas puis :
=> ${1:-*} signifie : Si $1 (le 1er argument) existe => prends-le.
Sinon, utilise * à la place.
Si on fait ./compte_lieux.sh 2017 => $1 = 2017
Si on fait ./compte_lieux.sh => $1 est vide => ANNEE=* => * signifie “toutes les années”.

Même logique pour ${2:-*} mais pour le 2e argument. Si on oublie de mettre le mois, il mettra "*" => "tous les mois".

Même logique pour ${3:-*} mais avec le nombre de lieux à afficher. Si $3 n'est pas donné, il prendra 10 ; c'est pour avoir un top 10 par défaut, on peut changer les valeurs selon nos besoins.


22/10/2025

Décrire le code du cours :

# !/ usr / bin / bash
if [ $ # - ne 1 ]

## if pour vérifier si le nombre total d'arguments passés au script est 
## différent de 1
## -ne signifie "not equal" 

then

## alors

echo " ce programme demande un argument "

## on renvoie à l'utilisateur un message afin qu'il ajoute des arguments 

exit
fi

## fin du if

F I C H I E R _ U R L S = $1

## on nomme un des arguments 

OK =0
NOK =0

## on crée des compteurs
## afin de les incrémenter grâce à la boucle while

while read -r LINE ;

## Tant qu'il y a des lignes à lire, stocker son contenu dans la variable
## 	LINE
## -r empêche Bash d'interpréter les antislashs comme des caractères
## spéciaux 

do
echo " la ligne : $LINE "
## renvoie "la ligne : $LINE (renverra un string en fonction 
## de la ligne parcourue

if [[ $LINE =∼ ^ https ?:// ]]

## si la ligne commence par https ?://

then ## alors
echo " ressemble à une URL valide "

## renvoie (c'est une verrification)
OK = $ ( expr $OK + 1)

## si c'est un URL valide on incrémente OK de 1

else ## autre
echo " ne ressemble pas à une URL valide "

## renvoie que a ne ressemble pas à une URL
NOK = $ ( expr $NOK + 1)

## si ce n'est pas une URL valide on invrémente NOK de 1

fi ## fin du fi

done < $ F I C H I E R _ U R L S
echo " $OK URLs et $NOK lignes douteuses "

## renvoie le nombre d'URLs valident et invalident 
## grâce aux résultats stockés dans les variables (arguments?)$OK et $NOK

25/10/2025

Questions (slides miniprojet.pdf):

code :

while read -r line;
do
echo ${line};
done < "urls/fr.txt";

Questions :

1. Pourquoi ne pas utiliser cat ?

On utilise pas cat car cette commmande ne fait qu'afficher le contenu \n
du fichier tandis qu'une boucle nous permet d'itérer sur un élément et \n
de vérifier s'il correspond aux critères souhaités. Ici nous souhaitons \n
vérifier pour chaque url et donc chaque ligne du fichier fr.txt stocké dans \n
le dossier urls.Si l'url est ok il seraa stocké au sein de la variable line. 

2. Comment transformer "urls/fr.txt" en paramètre du script ?

FICHIER=$HOME/PPE1-2526/miniprojet//urls/*.fr

for URL in $FICHIER
do

	while read -r line;
	do
		echo ${line};
	done < $URL;
done


2.1 Valider l’argument : ajouter le code nécessaire pour s’assurer qu’on 
donne bien un argument au script, sinon on s’arrête.

FICHIER=$HOME/PPE1-2526/miniprojet/urls*.fr

if [[ $# -eq 0 ]]; then
	echo "Erreur, il n'y a aucun fichier dans le dossier"
    exit 1
fi

echo "Arguments donnés : $1"

for URL in $FICHIER
do

        while read -r line;
        do
                echo ${line};
        done < $URL;
done


3. Comment afficher le numéro de ligne avant chaque URL (sur la même ligne)?

Pour afficher le numéro de la ligne avant chaque URL, il faut créer un compteur qui va venir compter les lignes puis afficher le résultat du compteur pour chaque ligne :

for URL IN $FICHIER
do
	while read -r line;
	do
		NUM_LIGNE=$(expr $NUM_LIGNE + 1)
		echo -e "ligne $NUM_LIGNE \t + $line";
	done < URL;
done


