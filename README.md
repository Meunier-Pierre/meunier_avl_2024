


# Etudiant       

MEUNIER Pierre      
M2 Genie Logiciel     
Année 2024-2025     

# Sujet    

Le sujet de ce TP est disponible en 3 endroits.     
L'un est les katas   

[kata.md](./kata.md)   

L'autre est le sujet de TP   

https://github.com/avl-univ-lille/testing/blob/2024/tp.md   

Et l'agenda de la note, et les TAG à écrire sont notés à    

https://github.com/avl-univ-lille/testing/blob/2024/agenda.md    

# Reponse    

Les réponses du TP1 sont écrits dans le fichier     
[Task1.md](./Task1.md)  


# Avancement  

**ATTENTION:**    
    - toujours mettre des tags (voir tp.md)     
	- Faire les practises    
	- Ne pas répondre aux questions d'aide du kata mais à celle dans tp.md     
	- Ne pas écrire les réponses dans un fichier question.md mais avec le nom donné dans tp.md     

**Je suis à:**    

- Faire les "Practise" a chaque cours   

- Faire le Kata (relire Kata) + Faire le fichier Task1.md avec les réponses attendues   
- Je dirais ne PLUS faire de Mooc car j'ai fait equivalent week1 / week2 je pense       

**Au besoin:**
    MOOC https://mooc.pharo.org/     



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
 


 



     
   

