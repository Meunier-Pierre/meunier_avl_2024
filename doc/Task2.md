

# Task 2 : Mutation Testing    

## Sommaire   

[Scores initiaux](#scores-initiaux)     
[Strategie Elimination mutant / Choix des Mutants à tuer](#strategie-elimination-mutant--choix-des-mutants-à-tuer)         
[Refactoring appel impossible, MyChessBoard >> initializePiece](#refactoring-appel-impossible-mychessboard--initializepiece)    
[Refactoring sur MyPawn >> targetSquaresLegal](#refactoring-sur-mypawn--targetsquareslegal)      
[Les tests que j'ai choisis d'écrire](#les-tests-que-jai-choisis-décrire)      
[Tests non écrits et pourquoi](#tests-non-écrits-et-pourquoi)      
[Score mutation final](#score-mutation-final)     
[Mutants Equivalents](#mutants-equivalents)     

## Scores initiaux

**Avant ajout de tests:**     

Taux de couverture: 54.61 % pour le package "Myg-Chess-Core".     
Score de mutation: 37%                     
Chance que un mutant couvert soit tué:  37 / 54.61 soit 67.8 %

**Obtention du score:**

Pour obtenir le score de mutation, j'ai effectué le test suivant.   
Un seul point **HYPER-IMPORTANT** j'ai modifié le testFilter afin de ne plus ignore les 10% de tests les plus    
lents. Sinon après écriture de tests, mon test le plus efficace, un test différentiel, était ignoré car > 0.019s.       

```

testPackages := {'Myg-Chess-Tests'.}.
packagesToMutate := {'Myg-Chess-Core'}.

analysis := MTAnalysis new
    testPackages: testPackages;
    classesToMutate: classesToMutate;
    testSelectionStrategy: MTSelectingFromCoverageTestSelectionStrategy new;
    stopOnErrorOrFail: true;
    testFilter: MTRedTestFilter new;
    budget: (MTTimeBudget for: 3 minutes).

analysis run.
analysis generalResult mutationScore.   
```

Pour obtenir les mutants survivants l'on peut remplacer la dernière ligne par "analysis generalResult."    



## Strategie Elimination mutant / Choix des Mutants à tuer    

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
MyPawn >> targetSquaresLegal : 39 mutants survivants avant refactoring, 27 après (6ème position)     
                                   Le refactoring est expliqué après.    


Après analyse, **MyChessSquare >> initialize** est un code graphique. Je vais donc dans la suite me concentrer     
uniquement sur les 3 fonctions restantes. 267 mutants sur plus de 600 encore vivants.     

**Les mutants choisis pour être tués spécifiquement:**    

**"2 Convert a literal string to emptyString in MyChessBoard>>#initializePiece"**    
    Au lieu de mettre MyKing White en 'e1' l'on met MyKing en ''    

**"12 Replace #or: with true in MyKnight>>#targetSquaresLegal:"**    
    Au lieu de select: [ :s | s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ] cela est remplacé par   
 select: [ :s | s notNil and: [ true ] ]    

**" Remove #not in MyPawn>>#targetSquaresLegal"**    
    Au lieu de select: select: [ :s |s notNil and: [ s hasPiece not ] ] cela est remplacé par  [ :s | s notNil and: [    
	s hasPiece ] ]   


## Refactoring appel impossible, MyChessBoard >> initializePiece

Comme je dois tester la méthode MyChessBoard >> initializePieces j'ai du essayer de l'appeller, et je me suis rendu   
compte que son appel est bloqué, car les fonctions inialization ne peuvent être appellées que dans un constructeur. Un     
appel très spécial. Et cette fonction la n'était jamais appellée par aucun constructeur. Cela ne serait pas la     
définition d'un code mort ?     

Cependant j'ai passé 3h sur le problème de comment appeller la méthode. Les tests de mutation disent que cette méthode   
est hyper importante. Bref, j'ai crée le constructeur  MyChessBoard >> initPieces pour appeler cette fonction.    

```
initPieces
   
		^ super new
		  initializePieces;
		  yourself
```

Et après nouveau soucis. Faire ainsi avec le code initial revient à avoir 2 tableaux au niveau des BlElements, les     
éléments graphiques. Bref, j'ai modifié le code initial, et j'ai appellé une méthode de BlElement "self removeChildren."    


## Refactoring sur MyPawn >> targetSquaresLegal

Comme je vais devoir tester les pions qui sont au départ bugués, j'en ai profité pour corriger une partie du code.     
Les mutants ne pouvant pas être tués avec des tests initialement jaunes. Il y a bien sur plusieurs bugs sur les pions   
mais j'ai réparé le bug le plus flagrant.   

Un pion pouvait manger un adversaire devant lui. J'ai réparé le bug en remplacant dans MyPawn >> targetSquaresLegal     
"s notNil and: [ s hasPiece not or: [ s contents color ~= color ]]" par "s notNil and: [ s hasPiece not]"       


## Les tests que j'ai choisis d'écrire  

Soit l'analyze des tests à effectuer. Je vais m'appuyer à la fois sur les mutants que j'ai choisis de tester, et la     
stratégie pour tuer les mutants que j'ai choisis dans "Strategie Elimination mutant / Choix des Mutants à tuer". 

Déjà beaucoup de mutation concerne "MyChessBoard>>#initializePiece". J'ai regardé le code, et on voit qu'il s'agit     
d'initialiser beaucoup de pièces. Comme l'on peut aussi initialiser un échequier avec une FEN, je vais faire     
ce que l'on appelle un "test différentiel". J'initialise des échequier de 2 façons, et je regarde si les résultats sont   
identiques.          

Concernant les 2 autres tests cela va être du test de mouvement simple comme effectué en Task1.    
Il va falloir trouver des cas précis à trouver, et tester les cases où l'on peut aller. Selon qu'il y a un opposant,    
qu'il n'y a pas d'opposant, que l'on soit au bord du plateau...    

**Les tests que je choisis d'implémenter vont donc être:**     
- Test différentiel entre MyChessBoard>>#initializePiece et le board de MyChessGame >> FromFENString:    
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' . Je regarde si les 2 fonctions renvoient des boards  
	   identiques.    
- Test des mouvement d'un cavalier en bord de plateau   
- Test qu'un cavalier ne peut pas manger un pion allié    
- un pion noir avance d'une case en bas   
- un pion blanc avec une tour noir devant ne peut pas avancer    
  

**Les tests ont été implémentés:**    
- MyChessBoardTests >> testInitPieces     
- MyKnightTests >> testMovesAtBorder      
- MyKnightTests >> testMovesWithSameColorObstacle    
- MyPawnTests >> testMoves
- MyPawnTests >> testMovesWithOponentObstacle   

J'ai vérifié que les mutants choisis sont tués en introduisant les mutations à la main.    
Les tests étaient soit rouges, soit jaunes après modification. Pari réussi.       


## Tests non écrits et pourquoi    


Déjà je n'ai écris aucun tests vérifiant les performances pour les fonctions de base.    
Car savoir qu'elle est une performance convenable est toujours très dur.   

De plus, je n'ai pas écrit de tests pour lequels peu de mutants ont survécus, car j'ai effectué ce que l'on appelle    
des "tests guidés" en l'occurence des tests guidés par le score de mutation.    

Cela est cohérent avec l'exercice demandé.    
Mais en pratique en entreprise il y a 2 effets indésirables:     
- Si le framework de test de mutation évite à tort certaines fonctions, à cause d'une mauvaise stratégie de génération    
l'on peut ne pas tester une fonction importante.    
- Un test guidé par du code et non des spécifications, peu ne pas voir certains cas de test. Spécifiquement si le    
développeur a oublié de coder des cas présents dans les spécifications. Ou non écrit en spécification mais implicite.   
Un cas déjà eu à Kiabi, est "Mais vous n'avez pas écrit en spécification que le flux ne devait pas renvoyer 100 fois    
le même CA dans la base de donnée destinataire". Véridique.    

## Score mutation final


Je refais les mêmes tests que au début, donc aussi en reprenant tout le package "Myg-Chess-Core".    
Bien que comme j'ai vu il y a aussi en fait pas mal de code graphique.   

**Taux de couverture:** 67.97 % pour le package "Myg-Chess-Core".     
**Score de mutation:** 64%.      
**Important:** Je suis passé de 49% à 64% de score de mutation en... Modifiant le test filter pour empecher   
de supprimer les tests > 0.019s. Sinon mon test "differential testing" était ignoré. Et il était efficace.      


**Conclusion:** Le score de mutation est nettemenent supérieur au début de 37 à 64%, alors que le taux de    
couverture est juste passé de 54.61% à 67.97%. Cela est du surtout au test "MyChessBoardTests >> testInitPieces"    
qui teste MyChessBoard >> InitializePieces.    
J'en déduis personnelement que cela montre un attrait spécifique du module de mutation pour certaines fonctions.   


## Mutants Equivalents    

J'avais trouvé 2 mutants graphiques qui pour moi étaient équivalents, changement de paramètres graphiques de 20 à 21, ou     
de 48 à 49. Mais j'ai cru comprendre que cela n'était pas vraiment des mutants équivalents pour le professeur.    

Je n'ai trouvé aucun mutants équivalents côté logique / backend.     
Je montre quand même des petits exemples pour montrer que j'ai cherché. Et que j'ai fais les tables de logique avec    
du or / bXor , and / bEqv.     


### III.1 Recherche échoué d'un mutant équivalent, mutant 90

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
Les deux variables sont liées car si cond1 est vraie, alors cond2 va appeller une fonction sur nil (crash).    
J'ai vérifié ce comportement en playground en demandant "square contents color" sur une case vide.      

La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.         

|                  | cond1 vraie cond2 NON EVALUABLE  | cond1 fausse cond2 vraie       | cond1 fausse cond2 fausse       | 
| :---------------:|:---------------:                 | :---------------:              | :---------------:               |   
| Avant mutation   |            Vrai                  |            Vrai                |             Faux                |   
| Après mutation   |            CRASH                 |            Vrai                |             Faux                |  


### III.2 Recherche échoué d'un mutant équivalent, mutant 147    

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

Les 2 variables ne sont pas liées. Car le roi n'a pas le droit de bouger sur une case où il est en danger.    
Mais le fait que les cases autour de lui soit en danger, n'a pas de lien avec le fait d'être en danger sur sa case actuelle.    

La comparaison est donc la suivante.    
L'on voit que le mutant n'est pas équivalent.     


|                  | cond1 vraie cond2 vraie  | cond1 vraie cond2 fausse       | cond1 fausse cond2 vraie|  cond1 fausse cond2 fausse |
| :---------------:|:---------------:         | :---------------:              | :---------------:       |    :---------------:       |
| Avant mutation   |            VRAI          |            FAUX                |      FAUX               |          FAUX              |
| Après mutation   |            VRAI          |            FAUX                |      FAUX               |          VRAI              |


