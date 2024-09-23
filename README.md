


# Etudiant       

MEUNIER Pierre      
M2 Genie Logiciel     
Année 2024-2025     

# Avancement  

**ATTENTION:**    
    - toujours mettre des tags (voir tp.md)    
	- Ne pas répondre aux questions d'aide du kata mais à celle dans tp.md     
	- Ne pas écrire les réponses dans un fichier question.md mais avec le nom donné dans tp.md     

**Je suis à:**    

- Faire les "Practise" a chaque cours + les mettres dans ma synthese ou un autre Fichier,   
     je ne sais pas... Ou Juste séparer par les "practise".      

- Kata choisit: Restrict Legal Move car il semble intéressant    
- Je dirais ne PLUS faire de Mooc     
- Voir le fichier suivant pour voir ce que je suis en train de faire                              
[Tache.md](./Tache.md)     

**Au besoin:**
    MOOC https://mooc.pharo.org/  j'ai fait la week1, mais d'après ma synthèse je pense que
	    cela comprend week1 et week2

# Sujet    

Le sujet de ce TP est disponible en 2 endroits.     
L'un est les katas   

[begin.md](./begin.md)   

L'autre est le sujet de TP   

https://github.com/avl-univ-lille/testing/blob/2024/tp.md   

Et l'agenda de la note, et les TAG à écrire sont notés à    

https://github.com/avl-univ-lille/testing/blob/2024/agenda.md    



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

La commande ci dessus a bien été modifiée pour pointé vers le projet de l'étudiant, comme cela est visible    
d'après le nom du projet git "Meunier-Pierre/..."      


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


 



     
   

