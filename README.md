


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

Je suis à:    
    -> Ecole je pull mon projet + ma classe ajoutée    
	-> Ne pas oublier d'installer en clic droit > Metacello    
	-> Rappel erreur : Il faut cliquer sur "Store Settings"    

Tutoriel Pharo disponible à     
https://mooc.pharo.org/    
**Marque page MOOC:**     
   -> J'ai fais toute Week1    
   -> Week2 j'ai juste vu comment parcourir classe    
   -> Regarder Week5, le pdf6 qui montre comment faire les tests unitaires    
   -> J'ai sauté pas mal suite à ce que le professeur demande...    

Ma synthèse Pharo est à la racine du projet      
  
 



     
   

