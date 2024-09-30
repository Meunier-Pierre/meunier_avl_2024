

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

Pour obtenir les mutants survivants j'effectue le code suivant.   
Seule la dernière ligne est modifiée.    

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
analysis generalResult.
``` 

## Strategie Elimination mutant     

La strategie que je vais suivre pour améliorer le score de mutation va être de grouper les mutants survivants par méthode mutée.    
Je vais aussi en profiter pour diminuer les classes testées, pour tester uniquement celles ou cela est plus facile à tester.    

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
MyChessBoard >> initializeFromFENBoard 36 mutants survivants    

## Elimination de 3 mutants précis     

Suite à ma stratégie d'élimination des mutants, je vais selectionner 3 mutants à tuer dans les cinq fonctions avec le   
plus de mutants survivants. Je vais évaluer que le mutant est bien tué en modifiant ensuite moi même mon code   
comme pour la mutation, et en vérifiant que le mutant est bien repéré.    

**Les mutants que j'ai choisit de tuer:**   

"2 Convert a literal string to emptyString in MyChessBoard>>#initializePiece"     
    Au lieu de mettre MyKing White en 'e1' l'on met '' en e1   

"12 replace #or: with true in MyKnight>>#targetSquaresLegal:"    
    Au lieu de select: [ :s | s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ] cela est remplacé par   
 select: [ :s | s notNil and: [ true ] ]    

**TO DO 3ème mutant à trouver**

**Les Tests que j'ai rajouté pour tuer les mutants:**    

**TO DO**

## Ecriture de Tests   

**TODO**

## Tests non écrits et pourquoi    

**TODO**

## Score mutation final

**TODO**

## Scores mutation initial 

En plus du score de mutation, je vais indiquer les taux de coverage. Et cela car un taux de     
mutation très éloigné du taux de coverage indique souvent un soucis, car dans le test les      
assertions ne sont pas assez fines.    

Je vais effectuer les tests sur mon code refactoré pour le kata "Restrict legal moves".      

**Warning: Bug coverage Dr Test**     

J'arrive à faire buguer Dr Test sur le coverage, et passer pour "Myg-Chess-Core" de 54.61%    
de coverage à 32.89%, et de 9/78 méthodes couvertes à 4/106. Pour éviter ce bug, je réimporte     
100% depuis github juste avant de lancer les tests. Surprenant, mais cela marche. Assez long.        

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

Mutant: Increase a little integer in MyChessGame>>#initializeFromFENGame
Est équivalent car: La marge n'a aucun importance, surtout pour une petite modification

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

Code muté

```
initializeFromFENGame: aFENGame

	...

	infoPane := ToElement new.
	infoPane constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	infoPane layout: BlLinearLayout vertical.
	infoPane layout cellSpacing: 10.
	infoPane margin: (BlInsets all: 21).
	infoPane matchParent.

    ...
```

### II. Changement de Font 48 à 49

Mutant: Increase a literal integer in MyChessSquare >>#contents
Est équivalent car: La police d'écriture n'a aucune importance, surtout pour une petite modification

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

Code muté

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
			 fontSize: 49;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
```

### III. Recherche mutant équivalent logique   

Ici je vais montrer que j'ai cherché des mutants équivalents.     
Et je vais montrer pourquoi ils ne sont pas équivalents.    
On va être sur de la condition or / xor, and / nand...   

### III.1 Premier exemple, mutant 90

Soit le mutant 90 "Replace #or: with #bXor: in MyPawn>>#TargetSquareLegel".    

Code original

```
targetSquaresLegal: aBoolean

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
```

Code muté

```
targetSquaresLegal: aBoolean

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not bXor: [ s contents color ~= color ] ] ]
```

Appelons    
**cond1:** s hasPiece not    
**cond2 :** s contents color ~= color   
Les deux variables sont liées car si cond1 est vraie, alors cond2 va soit appeller une fonction sur nil (crash),    
soit renvoyer une couleur nil. J'ai testé avec un code en playground cond2 sur une case vide, en vrai cela provoque un    
appel sur nil et un crash.        


La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.         

|                  | cond1 vraie cond2 NON EVALUABLE  | cond1 fausse cond2 vraie       | cond1 fausse cond2 fausse       | 
| :---------------:|:---------------:                 | :---------------:              | :---------------:               |   
| Avant mutation   |            Vrai                  |            Vrai                |             Faux                |   
| Après mutation   |            CRASH                 |            Vrai                |             Faux                |  


### III.2 Deuxième exemple, mutant 147    

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

Code muté

```
isCheckMated
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ self legalTargetSquares isEmpty bEqv: [
		  threatenedSquares includes: self square ]
```

Appelons    
**cond1:** legalTargetSquares isEmpty     
**cond2 :** threatenedSquares includes: self square   

Les 2 variables ne sont pas liées. Car le roi n'a pas le droit de bouger sur une case ou il est en danger.    
Mais le fait que les cases autour de lui soit en danger, n'a pas de lien avec le fait d'être en danger sur sa case actuelle.    

La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.     
Pour rappel bEqv est la même chose que "=".


|                  | cond1 vraie cond2 vraie  | cond1 vraie cond2 fausse       | cond1 fausse cond2 vraie|  cond1 fausse cond2 fausse |
| :---------------:|:---------------:         | :---------------:              | :---------------:       |    :---------------:       |
| Avant mutation   |            VRAI          |            FAUX                |      FAUX               |          FAUX              |
| Après mutation   |            VRAI          |            FAUX                |      FAUX               |          VRAI              |


##  Strategie 


-----------------

**TO DO** Ecrire en haut le nom des 3 mutants que j'ai décidé de tuer
**TO DO** Ecrire en haut le nom des tests que j'ai fait pour tuer ces mutants la    
**TODO** Selectionner 3 mutants à tuer + EXPLIQUER POURQUOI DES TESTS PAS ECRITS (rappel Biceps) + écrire des tests pour monter score mutation + 
expliquer strategie monter score mutation
**TODO** Rapport test à écrire parler "Right BICEPS"

**Evaluer par:**
Score mutation après >> **Hyper IMPORTANT**

A report of your work in a markdown file (Task2.md) in the root of that repository. The report should explain
the scripts and configuration you used to run the analysis
your initial mutation score
your mutation score after adding tests
what test you did not write and why
an in-detail explanation of 3 mutants you killed and how you killed them
an in-detail explanation of 3 equivalent mutants, explaining why they are equivalent

-----------------