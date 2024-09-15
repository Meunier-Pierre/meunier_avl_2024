


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
    -> J'arrive... je télécharge le projet, et bien mon projet à moi    
    -> Ecole et Maison faire le lien avec les repository en local   
	-> **ATTENTION** Prevoir les git push en avance, car cela va être compliqué...
	-> Quand je saurais comment je fais les git pull je l'écrirai en synthèse    
	-> **ATTENTION** à bien commit en 4 fois -> Commit local -> copier dans le vrai -> Git add -> Git commit -> Git push
	-> **ATTENTION** Pour les pull je ne sais pas trop comment je vais faire... je vais peut-être devoir    
	     retélécharger à chaque fois... ou juste les "git pull" fonctionneront et pas les git push.     
		Cela me semble possible.    

Tutoriel Pharo disponible à     
https://mooc.pharo.org/    
**Marque page MOOC:**     
   -> J'ai fais toute Week1    
   -> Week2 j'ai juste vu comment parcourir classe    
   -> Regarder Week5, le pdf6 qui montre comment faire les tests unitaires    
   - J'ai sauté pas mal suite à ce que le professeur demande...    

Ma synthèse Pharo est à la racine du projet      
  
 



     
   

