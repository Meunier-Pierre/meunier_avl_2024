

# Task 2 : Mutation Testing    

## Obtention des scores initiaux    

Pour obtenir les scores initiaux, j'ai effectué le test suivant.   
En plus des optimisations usuelles, j'ai demandé à effectuer le test sur 3 minutes.    
J'ai cherché certaines méthodes en analysant l'objet "MTAnalysis" et en regardant l'onglet Meta.    

```

testPackages := {'Myg-Chess-Tests'.}.
packagesToMutate := {'Myg-Chess-Core'}.

analysis := MTAnalysis new
    testPackages: testPackages;
    packagesToMutate:  packagesToMutate;
    testSelectionStrategy: MTSelectingFromCoverageTestSelectionStrategy new;
    stopOnErrorOrFail: true;
    budget: (MTTimeBudget for: 3 minutes).

analysis run.
analysis generalResult mutationScore.
```

Pour obtenir les mutants survivants j'effectue presque le même code.  
Seule la dernière ligne est modifiée en "analysis generalResult."


## Strategie Elimination mutant     

La strategie que je vais suivre pour améliorer le score de mutation va être de grouper les  mutants survivants     
par méthode mutée.  Je vais aussi en profiter pour diminuer les classes testées, pour tester uniquement celles     
ou cela est plus facile à tester.    

```

testPackages := {'Myg-Chess-Tests'.}.
classesToMutate := { MyChessBoard. MyChessSquare. MyPiece. MyBishop. MyKing. MyKnight. MyPawn. MyQueen. MyRook.}.


analysis := MTAnalysis new
    testPackages: testPackages;
    classesToMutate: classesToMutate;
    testSelectionStrategy: MTSelectingFromCoverageTestSelectionStrategy new;
    stopOnErrorOrFail: true;
    budget: (MTTimeBudget for: 3 minutes).

analysis run.

((analysis generalResult aliveMutants)
	groupedBy: [ :m |m mutant originalMethod ])
		associations sorted: [ :a :b | a value size > b value size ].
```

**Les résultats:** 
MyChessBoard >> initializePiece : 193 mutants survivants   
MyChessSquare >> initialize : 116 mutants survivants    
MyKnight >> targetSquaresLegal : 47 mutants survivants   
MyPawn >> targetSquaresLegal : 39 mutants survivants    
MyChessBoard >> initializeFromFENBoard: 36 mutants survivants    
MyChessBoard >> initialize: 31 mutants survivants  

Après analyse, MyChessSquare >> initialize et MyChessBoard >> initialize sont du code graphique.      
MyChessBoard >> initializeFromFENBoard est... un code assez spécial que je ne comprends pas.       
Je vais donc dans la suite me concentrer uniquement sur les 3 fonctions restantes.    
279 mutants sur plus de 600 encore vivants.     

## Selection de 3 mutants a tuer        

Suite à ma stratégie d'élimination des mutants, je vais selectionner 3 mutants à tuer dans les six fonctions avec le   
plus de mutants survivants. Je vais évaluer que le mutant est bien tué en modifiant ensuite moi même mon code   
comme pour la mutation, et en vérifiant que le test passe de vert à jaune.   

**Les mutants que j'ai choisit de tuer:**   

"2 Convert a literal string to emptyString in MyChessBoard>>#initializePiece"     
    Au lieu de mettre MyKing White en 'e1' l'on met '' en e1   

"12 Replace #or: with true in MyKnight>>#targetSquaresLegal:"    
    Au lieu de select: [ :s | s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ] cela est remplacé par   
 select: [ :s | s notNil and: [ true ] ]    

 "x Replace Select block with [:each |true] in MyPawn>>#targetSquaresLegal:"    
    Au lieu de select: [ :s | s notNil and: [s hasPiece not or: [ s contents color ~= color ] ] ] cela est remplacé par   
[:each |true]     

Bon au vue du mutant assez grossier qui passait dans les pions, j'ai vérifié, et oui il y avait 0 tests sur le pion.    
Ce n'était pas nécessairement dans mon Kata, mais on va réparer cela.   

## Les tests que je choisis d'écrire  

Alors ici cela va être le plus intéressant.    
L'analyse de ce que je veux tester. Je vais m'appuyer à la fois sur les mutants que j'ai choisis de tester, et la stratégie   
pour tuer les mutants que j'ai choisis dans "Strategie Elimination mutant". Et en fait je vais juste tester extensivement    
3 fonctions qui represente 279 mutants survivants sur plus de 600.         

Déjà une grosse partie du code est sur l'initialisation de l'echequier avec "MyChessBoard>>#initializePiece". J'ai    
regardé le code, et on voit qu'il s'agit d'initialiser beaucoup de pièces. Cela va être façile à tester. Comme je sais que    
l'on peut aussi initialiser un échequier avec une FEN, je vais juste faire ce que l'on appelle un "test différentiel".        
J'initialise un echequier avec "initialize Piece", un avec une stringFEN. Et je compare si les 2 échequiers sont    
identiques en termes de comportement.         

Concernant les 2 autres tests cela va être du test de mouvement simple comme effectuer en Task1.    
Il va falloir trouver des cas précis à trouver, et tester les cases ou l'on peut aller. En gardant en tête que les pions   
sont un peu bugué. Et que en mutation, il faut un test vert au départ. Donc je vais tester uniquement les fonctionnalitées    
correctes.   

Les tests que je choisis d'implémenter vont donc être:     
**TODO: Ecrire tests en francais**    

J'ai écris les tests.     
Le nom dans mon code sont:      

**TODO : Ecrire le nom des fonctions** 


Après tests les mutants sont bien tués.    
Il est maintenant temps de vérifier les nouveaux scores de mutation et de couverture.    

**TODO: Vérifier que les mutants sont bien tués**


## Tests non écrits et pourquoi    

Déjà je n'ai écris aucun test vérifiant les performances avec un timeout pour les fonctions.    


De plus, je n'ai pas écrit de tests pour lequels peu de mutants ont survécu, car j'ai effectué ce que l'on appelle    
des "tests guidés" en l'occurence des tests guidés par le score de mutation.    

Cela est cohérent avec l'exercice demandé.    
Mais en pratique en entreprise il y a 3 effets indésirables:     
- Si le framework de test de mutation évite à tort certaines fonctions, à cause d'une mauvaise stratégie de génération    
l'on peut ne pas tester une fonction importante.    
- Un test guidé par du code et non des spécifications, peu ne pas voir certains cas de test. Spécifiquement si le    
développeur a oublié de coder des cas présents dans les spécifications. Ou non écrit en spécification mais implicite.   
Un cas déjà eu à Kiabi, est "Mais vous n'avez pas écrit en spécification que le flux ne devait pas renvoyer 100 fois    
le même CA dans la base de donnée destinataire". Véridique.    

## Score mutation final

**TODO ecrire score mutation final**

## Scores mutation initial 

En plus du score de mutation, je vais indiquer les taux de coverage. Et cela car un taux de     
mutation très éloigné du taux de coverage indique souvent un soucis, car dans le test les      
assertions ne sont pas assez fines.    

Je vais effectuer les tests sur mon code refactoré pour le kata "Restrict legal moves".           

**Score initial:**     

Taux de couverture: 54.61 % pour le package "Myg-Chess-Core".     
Score de mutation: 37%                     
Chance que un mutant couvert soit tué:  37 / 54.61 soit 67.8 %

Note: Comme le TP fourni un jeu volontairement bugué, et que j'ai 3 tests "yellow", car le    
refactoring total était compliqué, cela baisse aussi les chances de tuer un mutant couvert.   

## Mutants Equivalents    

J'ai trouvé 2 mutants équivalents que j'explique en 1. et 2.    
Il s'agit de mutants graphiques.    

Je n'ai trouvé aucun mutant équivalent côté logique / backend.    
Je montre dans "III. Recherche mutant équivalent Logique" un peu du travail que j'ai effectué pour essayer de    
chercher des mutants équivalents sur des conditions.    


### I. Augmentation de la marge de 20 à 21

**Mutant:** Increase a little integer in MyChessGame>>#initializeFromFENGame
**Est équivalent car:** La marge n'a aucun importance, surtout pour une petite modification

Code original

```
initializeFromFENGame: aFENGame

	...

	infoPane := ToElement new.
	infoPane constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	infoPane layout: BlLinearLayout vertical.
	infoPane layout cellSpacing: 10.
	infoPane margin: (BlInsets all: 20).
	infoPane matchParent.

    ...
```

**Code muté :** Dans "infoPane margin: (BlInsets all: 20)." le 20 devient un 21



### II. Changement de Font 48 à 49

**Mutant:** Increase a literal integer in MyChessSquare >>#contents
**Est équivalent car:** La police d'écriture n'a aucune importance, surtout pour une petite modification

Code original

```
contents: aPiece

	| text |
	contents := aPiece.

	text := contents
		        ifNil: [
			        color isBlack
				        ifFalse: [ 'z' ]
				        ifTrue: [ 'x' ] ]
		        ifNotNil: [ contents renderPieceOn: self ].
	piece text: (text asRopedText
			 fontSize: 48;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
```

**Code muté:** Remplacement de "fontSize: 48;" par "fontSize: 49;"


### III. Recherche mutant équivalent logique   

Ici je vais montrer que j'ai cherché des mutants équivalents.     
Et je vais montrer pourquoi ils ne sont pas équivalents.    
On va être sur de la condition or / xor, and / nand...   

### III.1 Premier exemple mutant équivalent, mutant 90

Soit le mutant 90 "Replace #or: with #bXor: in MyPawn>>#TargetSquareLegel".    

Code original

```
targetSquaresLegal: aBoolean

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
```

**Code muté:** Remplacement du "or:" par "bXor:"


Appelons    
**cond1:** s hasPiece not    
**cond2 :** s contents color ~= color   
Les deux variables sont liées car si cond1 est vraie, alors cond2 va soit appeller une fonction sur nil (crash).    
J'ai vérifié ce comportement en playground en demandant "square contents color" sur une case vide.      

La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.         

|                  | cond1 vraie cond2 NON EVALUABLE  | cond1 fausse cond2 vraie       | cond1 fausse cond2 fausse       | 
| :---------------:|:---------------:                 | :---------------:              | :---------------:               |   
| Avant mutation   |            Vrai                  |            Vrai                |             Faux                |   
| Après mutation   |            CRASH                 |            Vrai                |             Faux                |  


### III.2 Deuxième exemple mutant équivalent, mutant 147    

Soit le mutant 147 "Replace #and with #bEqv: in MyKing>>#isCheckMated".     

Code original

```
isCheckMated
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ self legalTargetSquares isEmpty and: [
		  threatenedSquares includes: self square ]
```

**Code muté:** Remplacement de "and:" par "bEquv:"


Appelons    
**cond1:** legalTargetSquares isEmpty     
**cond2 :** threatenedSquares includes: self square   

Les 2 variables ne sont pas liées. Car le roi n'a pas le droit de bouger sur une case ou il est en danger.    
Mais le fait que les cases autour de lui soit en danger, n'a pas de lien avec le fait d'être en danger sur sa case actuelle.    

La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.     


|                  | cond1 vraie cond2 vraie  | cond1 vraie cond2 fausse       | cond1 fausse cond2 vraie|  cond1 fausse cond2 fausse |
| :---------------:|:---------------:         | :---------------:              | :---------------:       |    :---------------:       |
| Avant mutation   |            VRAI          |            FAUX                |      FAUX               |          FAUX              |
| Après mutation   |            VRAI          |            FAUX                |      FAUX               |          VRAI              |




-----------------

**TO DO** J'ai 4 TODO en haut. Les faires. 3 sont pour écrire des tests.    
Et 1 est pour le truc hyper important de dire les scores finaux !!      

-----------------