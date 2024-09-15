


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

# Export du projet    

ATTENTION penser à faire Pharo > Save à chaque fois.     
Pour exporter le projet, il faut

**TO DO**

# Avancement         

-> Faire un compte GitHub pour que le professeur puisse voir mon TP    

Tutoriel Pharo disponible à     
https://mooc.pharo.org/    

Pour les vidéos cliquer sur "Subtitles" en cours, son non disponible.   
 
**Je suis à :**       
W1-S04-PharoModelInANutshell    

Ma synthese Pharo est disponible à **Synthese.doc**      


# Sujet de TP      

Le projet à debuguer sera https://github.com/UnivLille-Meta/Chess       


**TO DO:** A ecrire

