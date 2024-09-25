


# Qu'elle sont les fonctionnalitées à tester    

J'ai choisit le kata "Restrict legal moves". Je vais devoir tester que les mouvements lorsque le roi est en echec      
sont correctement restreints. Et cela pour le roi ou les autres pieces.    

Afin de vérifier que tout fonctionne bien, il y a 2 grands types de cas à vérifier.    
La fonction ayant pour effet de restreindre les mouvements, il faut vérifier que l'on ne puisse pas faire de     
mouvements invalides, mais aussi que l'on puisse toujours faire les mouvements valides.     

**Cas NON-PASSANT trouvés / Mouvement interdits:**    
- Sans cas de danger > un roi ne doit pas pouvoir se mettre sur une classe ou il deviendrait en danger   
- Sans cas de danger > une piece non roi ne doit pas pouvoir bouger si elle met son roi en danger
- Cas d'Echec > le roi ne doit pas pouvoir bouger sur une case ou il serait encore en danger  
- Cas d'Echec > Une piece non-roi ne doit pas pouvoir bouger si son mouvement ne protege pas le roi : manger l'attaquant ou bloquer sa ligne de vue 
- Echec et Mat  > Le roi ne doit plus pouvoir bouger 
- Echec et Mat > Une pièce non-roi ne doit plus pouvoir bouger 

**Cas PASSANT trouvés / Mouvement autorisés:**        
- Sans cas de danger > Le roi doit pouvoir bouger sur toute les cases ou il n'est pas en danger 
- Sans cas de danger > Une piece non-roi doit pouvoir bouger s'il ne met pas le roi en danger   
- Cas d'Echec >  Le roi doit pouvoir bouger pour ne plus être en danger      
- Cas d'Echec > Le roi doit pouvoir bouger pour pouvoir manger son attaquant    
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour bloquer la ligne de vue de l'attaquant  
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour manger l'attaquant    

# Tests écrits et pourquoi   

Le nombre de 12 tests est réalisable, et j'ai donc écrit tous ces tests.     

J'ai choisis de tester différents type de pièce non-roi, au cas ou une classe enfant réécrit une méthode utile   
d'une classe parent. L'on pourrait alors s'attendre à une erreur...      

**Les Tests écrits pour le roi ont étés:**    
- MyKingTests >> testCantMoveInCheck    
- MyKingTests >> testCantStayInCheck    
- MyKingTests >> testMovesWhenNoCheck       
- MyKingTests >> testNoMovesWhenCheckmate     
- MyKingTests >> testCanMoveOutOfCheck     
- MyKingTests >> testCanEatAttackerWhenInCheck   

**Les Tests écrits pour la reine ont étés:**    
- MyQueenTests >> testCantMoveIfKingInCheckAfter     
- MyQueenTests >> testMovesWhenNoCheck    

**Les Tests écrits pour le cavalier ont étés:** 
- MyKnightTests >> testIfCheckCantMoveIfStayInCheck       
- MyKnightTests >> testIfCheckCanMoveToProtectKing    

**Les Tests écrits pour la tour ont été:**
- MyRookTests >> testNoMovesWhenCheckmate    
- MyRookTests >> testIfCheckCanMoveToEatAttacker    


# Tests non écrits et pourquoi    

Il n'y a pas de tests non écrits.     

# Les Tests échoués      

Sur les 12 tests, 5 tests ont échoués.   

MyKingTests >> testCanEatAttackerWhenInCheck   
MyKingTests >> testCantStayInCheck    
MyQueenTests >> testCantMoveIfKingInCheckAfter    
MyKnightTests >> testIfCheckCantMoveIfStayInCheck   
MyRookTests >> testNoMovesWhenCheckmate    

En regardant les tests, l'on se rend compte que le jeu présente les bugs suivants:    
1. Lorsque le roi est en echec, ses mouvements deviennent restreints...  Mais il y a quelques    
soucis avec l'algorithme utilisé.    
2. Les pièces autres que le roi n'ont aucun mouvement restreint lorsque le roi est en echec,    
ou echec et mat. Hors cela devrait être le cas.     

# Refactoring   

Je n'ai pas effectué de refactoring pour faire passer les tests.   
Par manque de temps.    