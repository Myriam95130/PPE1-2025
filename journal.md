# Journal de bord du projet encadré
## Mise en pratique de git

Aujourd'hui, j'ai appris à modifier mon journal de bord depuis ma machine au
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
