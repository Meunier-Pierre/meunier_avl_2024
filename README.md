


# Etudiant       

MEUNIER Pierre      
M2 Genie Logiciel     
Année 2024-2025     

# Sujet    

Le sujet de ce TP est disponible à    

[TP.md](./TP.md)   



# Import du projet     

Pour importer le projet de l'étudiant, après avoir ouvert  une image Pharo 12.0 il faudra ouvrir le    
playground avec Browse > Playground puis utiliser la commande

```
Metacello new
	repository: 'github://Meunier-Pierre/meunier_avl_2024:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

La commande ci dessus a bien été modifiée pour pointé vers le projet de l'étudiant, comme cela est visible d'après     
le nom du projet git "Meunier-Pierre/..."      


# Export du projet étudiant   

Voir dans ma synthèsePharo.     
Partie à supprimer après.    

# Execution

Une fois le projet importé, vous pouvez l'executer en ouvrant le playground avec Browse > Playground     
puis utiliser la commande     

```
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```

# Kata choisi   

Le Kata choisit par l'étudiant, pour programmer le Kata et faire les tests, est le suivant.

### Restrict legal moves

**Goal:** Practice code understanding, refactorings and debugging

In chess, when we are not in danger we can move any piece we want in general, as soon as we follow the rules.
However, when the king gets threatened, we must protect it!
The only legal moves in that scenario are the ones that save the king (or otherwise we lose).
What are moves that protect the king? The ones that capture the attacker, block the attack, or move the king out of danger.
Another way to see it is: A move protects the king if it moves it out of check.

The current implementation does not support this restriction.
As any *complicated* feature, the original developer (Guille P) left this for the end, and then left the project.
But you can do it.

Questions and ideas that can help you in the process:
- What tools help you finding the right place to put this new code?
- How do you avoid repeating all the existing code computing legal moves and checks?

### Reponse au Kata   

**What tools help you finding the right place to put this new code?**     

Dans Browse > System Browser j'ai utilisé les outils suivants pour trouver l'endroit ou mettre le code.    
1- Filter les Packages par "myg"     
2- Lecture des noms de fonction dans les classes "MyChessBoard" "MyChessGame" "My Piece" et "MyKing"    
3- Filtrage des fonctions par protocoles comme "rendering" ou "testing"       
4- Utilisation sur les fonctions de classe de la commande clic droit > Implementors pour voir rapidement, toutes les implementations   
     dans les classes enfants. Un exemple intéressant est la méthode "targetSquaresLegal" de la classe "MyPièce".    
5- Utilisation sur les fonctions de classe de la commande clic droit > Senders pour voir qu'elles fonctions appellent notre fonction.    
     Par exemple j'ai regardé la fonction My King >> IsCheckMated, et j'ai remarqué qu'elle était appellé par MyChessGame >> checkForMate,    
	 appellé par MyChessGame >> play.    


**How do you avoid repeating all the existing code computing legal moves and checks?**      

**TO DO**     


# Avancement         

**Attention appris prof:**
   -> On doit se concentrer sur UN SEUL Kata en fait 
   -> J'ai vérifié professeur par question, on fait les test QUE sur mon Kata.
   -> Vérifié professeur, on doit faire des tests sur notre Kata MEME si non écrit

**Je pense:**
    -> Chaque seance voir un peu ce qui est marqué en "pratique" en plus de la synthèse. Mais 
	synthèse de base plus importante.

**Je suis à:**    
    

Kata choisit: Restrict Legal Move car il semble intéressant    


Synthese MOOC https://mooc.pharo.org/ faire jusqu'a week3 avec video + redo + bonne synthese    
        actuel MOOC: Video, et redo du week1    

0.  Supprimer/Modifier le test sur les mouvements de pion car mauvais mouvement mis + ne fait pas partis de mon Kata
0.bis  Synthese avancer
1.  Plusieurs Tests unitaires sur le Kata. J'ai vérifié avec professeur ne faire les tests QUE sur mon Kata.
	1.1 - Penser les tests en francais
	1.2 - Les ecrires. Petite difficulté comment -->
			    Idee > FEN test on voit comment on ecrit. Et voir appeller MyChessBoard >> initializeFromFENBoard
				   ET TESTER EN PLAYGROUND
2. Programmer le Kata + garder en tête la question 2 du Kata
2. Repondre a la question 2 du Kata dans la partie du md "Reponse au Kata"
	

Liste des Bugs:
	Le pion devrait pouvoir bouger de 2 case au debut
	Le pion devrait pouvoir manger en diagonale
	Le pion ne devrait pas pouvoir manger vers l'avant, hors actuellement il le peut
	Si le roi est mangé et que l'on clique sur Play (n'arrive pas si on le fait à la main) , une Exception est levée
  
  

Ma synthèse Pharo est à la racine du projet      
  
 



     
   

