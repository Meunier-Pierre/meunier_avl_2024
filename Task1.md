


# Qu'elle sont les fonctionnalitées à tester    

En lisant le kata je vois qu'ils y a plusieurs cas.    
L'on va en effet devoir faire une fonction qui restreint les mouvements lorsque le roi est en echec.    
Et cela pour le roi ou les autres pieces.    

Afin de vérifier que tout fonctionne bien, il y a 2 grands types de cas à vérifier.    
La fonction ayant pour effet de restreindre les mouvements, il faut vérifier que l'on ne puisse pas faire de     
mouvements invalides, mais aussi que l'on puisse toujours faire les mouvements valides.     

**J'ai vu trois cas de tests qui m'ont eu l'air de pouvoir facilement passer inapercue:**    
- Si le roi n'est pas en echec, les autres pièces doive pouvoir se déplacer librement... Sauf si cela met le roi en danger.   
- Si le roi n'est pas en echec, il doit pouvoir se deplacer librement... Sauf s'il se met alors en danger        
- En cas d'echec et mat plus aucun deplacements ne doit être proposés   

Après une petite réflexion, j'obtiens donc en totalité les tests suivants.   

**Pour les cas NON-PASSANT (mouvement interdit):**    
- Sans cas de danger > un roi ne doit pas pouvoir se mettre sur une classe ou il deviendrait en danger   (Fait)
- Sans cas de danger > une piece non roi ne doit pas pouvoir bouger si elle met son roi en danger   
- Cas d'Echec > le roi ne doit pas pouvoir bouger sur une case ou il serait encore en danger   (Fait)
- Cas d'Echec > Une piece non-roi ne doit pas pouvoir bouger si son mouvement ne protege pas le roi : manger l'attaquant ou bloquer sa ligne de vue    
- Echec et Mat  > Aucun deplacement ne doit être autorisé    (Fait partiel - Juste King)

**Pour les cas PASSANT:**        
- Sans cas de danger > Le roi doit pouvoir bouger sur toute les cases ou il n'est pas en danger  (Fait) 
- Sans cas de danger > Une piece non-roi doit pouvoir bouger s'il ne met pas le roi en danger     
- Cas d'Echec >  Le roi doit pouvoir bouger pour ne plus être en danger  (Fait)     
- Cas d'Echec > Le roi doit pouvoir bouger pour pouvoir manger son attaquant (Fait)    
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour bloquer la ligne de vue de l'attaquant    
- Cas d'Echec > Une piece non-roi doit pouvoir bouger pour manger l'attaquant    

# Tests écrits et pourquoi   

J'ai choisis de suivre la méthodologie suivante.   

1- J'aurai pu fusionner les cas dit passant et non passant pour dire "J'ai des cases interdites, des    
case autorisés, et je ne vois que celles attendus" mais le titre d'un tel test aurait été horrible.    
J'ai donc écrit les tests dit juste avant.    

2- Tester différents type de pièce non-roi, au cas ou une classe enfant réécrit une méthode utile   
d'une classe parent. L'on pourrait alors s'attendre à une erreur...      

Concretement les tests écrits ont été:    
- MyKingTest >> testCantMoveInCheck    
- MyKingTest >> testCantStayInCheck    
- MyKingTest >> testMovesWhenNoDanger    
- MyKingTest >> testNoMovesWhenCheckmate     
- MyKingTest >> testCanMoveOutOfCheck     
- MyKingTest >> testCanEatAttackerWhenInCheck 

- Pas d'echec > Le roi peut se deplacer tant qu'il ne ne se met pas en danger   

**TODO: ecrire les tests**
**Utiliser legalTargetSquares qui est ce qui est appellé par le move**

**Refactoring: Modifier MyPiece >>legalTargetSquares, qui utilise MyPiece >> targetSquaresLegal**

---------------
Utiliser:

board := MyChessBoard empty.

--------

# Tests non écrits et pourquoi    


----------------------------- SUREMENT INUTILE --------------

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