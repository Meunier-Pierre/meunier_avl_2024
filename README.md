


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

# Avancement         

**Attention appris prof:**
   -> On doit se concentrer sur UN SEUL Kata en fait 
   -> Ont doit faire test
   -> Ont peut faire plus en réparant le bug
   -> On peut faire plus en refactorant  

**Je pense:**
    -> Chaque seance voir un peu ce qui est marqué en "pratique" en plus de la synthèse. Mais 
	synthèse de base plus importante.

Je suis à:    
    -> Kata choisit: Restrict Legal Move car il semble intéressant
	-> 1- Programmer
	- > 2 - Tester

	
    
    -> Je me suis trompé pour le bug du pion donc... voir à recoder.
	    Mouvement pion réexpliquer dans le sujet.  

Liste des bugs trouvés:    
     - Les pions devraient pouvoir avancer de 2 cases au debut     
	 - Les pions ne mangent pas en diagonale actuellement et devrait pouvoir le faire    
	 - Les pion actuellement peuvent manger vers l'avant ce qui devrait etre interdit

Liste des bugs trouvés hors de mon Kata:    
     - Si le roi est tué l'on recoit a chaque fois que l'on appuye sur "Play" un "NotFound : [p: | p isKing] notfound in Array".   
	      Le roi est la seule pièce concerné. Et uniquement si l'on appuie sur le bouton play, et non si on fait cela à la main.   

Tutoriel Pharo disponible à     
https://mooc.pharo.org/    
**Marque page MOOC:**     
   -> J'ai fais toute Week1    
   -> Week2 j'ai juste vu comment parcourir classe    
   -> Regarder Week5, le pdf6 qui montre comment faire les tests unitaires    
   -> J'ai sauté pas mal suite à ce que le professeur demande...    

Ma synthèse Pharo est à la racine du projet      
  
 



     
   

