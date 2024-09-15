


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

# Avancement         

Tutoriel Pharo disponible à     
https://mooc.pharo.org/    
**Je suis à:** W1 video, puis Week2 ou3... A voir, le professeur semblait dire que l'on    
pouvait directement passer en week3.       
Ma synthèse Pharo est à la racine du projet    

1- Suivre tutoriel / Synthèse, créer une classe juste     
2 - Faire un Pharo > Save    
3- Exporter sur git, et verifier si pris en compte    
4- Créer 1/2 test unitaire    
5- git push mes tests unitaires   

**Après:** suivre le sujet de TP   


# Export du projet    

ATTENTION penser à faire Pharo > Save à chaque fois.     
Pour exporter le projet, il faut

**TO DO**  

     
   

