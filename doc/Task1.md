


# Qu'elle sont les fonctionnalitées à tester    

J'ai choisit le kata "Restrict legal moves". Je vais devoir tester que les mouvements lorsque le roi est en      
echec sont correctement restreints. Et cela pour le roi ou les autres pieces.    

Afin de vérifier que tout fonctionne bien, il y a 2 grands types de cas à vérifier.    
La fonction ayant pour effet de restreindre les mouvements, il faut vérifier que l'on ne puisse pas faire     
de mouvements invalides, mais aussi que l'on puisse toujours faire les mouvements valides.      

**Cas NON-PASSANT trouvés / Mouvement interdits:**    
- Sans cas de danger > un roi ne doit pas pouvoir se mettre sur une case où il deviendrait en danger   
- Sans cas de danger > une piece non roi ne doit pas pouvoir bouger si elle met son roi en danger
- Cas d'Echec > le roi ne doit pas pouvoir bouger sur une case ou il serait encore en danger  
- Cas d'Echec > Une piece non-roi ne doit pas pouvoir bouger si son mouvement ne protege pas le     
roi : manger l'attaquant ou bloquer sa ligne de vue 
- Echec et Mat  > Le roi ne doit plus pouvoir bouger 
- Echec et Mat > Une pièce non-roi ne doit plus pouvoir bouger 

**Cas PASSANT trouvés / Mouvement autorisés:**        
- Sans cas de danger > Le roi doit pouvoir bouger sur toute les cases où il n'est pas en danger 
- Sans cas de danger > Une piece non-roi doit pouvoir bouger s'il ne met pas le roi en danger   
- Cas d'Echec >  Le roi doit pouvoir bouger pour ne plus être en danger      
- Cas d'Echec > Le roi doit pouvoir bouger pour pouvoir manger son attaquant    
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour bloquer la ligne de vue de l'attaquant  
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour manger l'attaquant    

# Tests écrits et pourquoi   

Le nombre de 12 tests est réalisables, et j'ai donc écrit tous ces tests.     

J'ai choisis de tester différents types de pièces non-roi, car il serait possible que certaines    
pièces implémentent bien la fonction et d'autres non.        

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
Un total de 12 tests à écrire étant réalisable.    

# Les Tests échoués      

Sur les 12 tests, 5 tests ont échoués.   

MyKingTests >> testCanEatAttackerWhenInCheck   
MyKingTests >> testCantStayInCheck    
MyQueenTests >> testCantMoveIfKingInCheckAfter    
MyKnightTests >> testIfCheckCantMoveIfStayInCheck   
MyRookTests >> testNoMovesWhenCheckmate    

En regardant les tests, l'on se rend compte que le jeu présente les bugs suivants:    
1. Lorsque le roi est en echec, ses mouvements deviennent restreints...  Mais il y a quelques    
soucis avec l'algorithme utilisé. Par exemple l'algorithme empeche le roi de manger quelqu'un.    
J'ai vérifié cela avec des tests manuels.        
2. Les pièces autres que le roi n'ont aucun mouvements restreints lorsque le roi est en echec,    
ou echec et mat. Hors cela devrait être le cas.     

# Refactoring   

J'ai commencé à faire des modifications dans le code pour résoudre les bugs détectés.    
Mon idée de départ, était lorsque l'on demandait les mouvements, de tester chaque coup valide sur     
des echequiers copies, puis de voir si l'on est en echec après le coup. Mais cela provoquait la     
boucle infinie suivante        

legalTargetSquares >> appel isInCheck >> appel legalTargetSquares >> appel isInCheck....    

J'ai donc codé seulement les modifications d'après.    
 

- **MyKing >> targetSquaresLegal (Protocol Rendering):**    

Le roi ne pouvait pas manger de pièce car targetSquaresLegal incluait le code    

```
"Let's hope the piece is not defended"
threatenedSquares includes: s   
```

que j'ai remplacé par le code pharo suivant, en suivant le commentaire.       

```
"Let's hope the piece is not defended"
(threatenedSquares includes: s) not 
```

- Ajout des méthodes **MyPiece >> MyKing (Accessing)** et **MyPiece >> MyKingAttacker (Accessing)**.    
Méthodes utilisées après par la fonction legalTargetSquares après recodage.     

- **MyPiece >> legalTargetSquares (path commands):**    

Les pièces pouvait se déplacer librement, même en cas d'echec du roi. J'ai décidé en cas d'echec de ne      
plus permettre à la pièce de se déplacer, sauf pour manger une pièce attaquant le roi. J'ai remplacé le     
code     

```
legalTargetSquares
    ^ self targetSquaresLegal: true
```

par

```

legalTargetSquares

   |list attacker attackerSquare result|.
   list := self targetSquaresLegal: true.

   (self isKing) ifTrue:[
       ^ list.
    ] ifFalse:[
        attacker := self myKingAttacker.
        attacker isNil ifTrue:[^ list].
       
        result := OrderedCollection new.
        attackerSquare := attacker square.
        result add: attackerSquare.
        (list includes: attackerSquare) ifTrue: [ ^ result] 
	                                    ifFalse: [ ^ #() ].
    ].

	
```

# Resultat du refactoring   

Grace au refactoring je suis passé de 5/ 12 tests en erreurs, à 3 / 12 tests.   
Cela ne sont pas les mêmes tests qu'avant.   

MyKingTests >> testCantStayInCheck   
MyKnightTests >> testIfCheckCanMoveToProtectKing     
MyQUeenTests >> testCantMoveIfKingInCheckAfter   
