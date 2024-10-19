
# Task 3: fuzzing, oracles and property based testing    

## Sommaire   

[Presentation des strings FEN](#presentation-des-strings-fen)        
[Fuzzer : Implementation de la grammaire](#fuzzer--implementation-de-la-grammaire)      
[Test Oracle](#test-oracle)      
[Premier résultat](#premier-résultat)     
[Fuzzer : Besoin d'une nouvelle Grammaire](#fuzzer--besoin-dune-nouvelle-grammaire)    
[Second résultat](#second-résultat)       
[Fuzzer : Mutation Testing](#fuzzer--mutation-testing)   
[Troisième résultat](#troisième-résultat)   
[Resultats finaux](#resultats-finaux)     

  
## Presentation des strings FEN  

Pour bien concevoir un Fuzzing par grammaire, je me suis déjà renseigné sur la façon de faire des chaines FEN.    
Les chaines FEN se pressentent comme   

rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1    

Il y a 6 champs, chacun séparés par un espace.    

### 1er champ: Le plateau 

- 8 rangés de 8 cases séparées par "/".    

- Les pièces blanches sont en majuscule, et les noires en majuscules.  

- Si l'on écrit un nombre, cela veut dire qu'il y a autant de cases vides.   

- Les pièces rook, knight, bishop, queen, king, pawn sont représentées par les lettres "r", "n", "b", "q",    
"k", "p".   

### 2eme champ: Le joueur   

L'on écrit w pour dire que cela est le tour du joueur White / Blanc.   
L'on écrit b pour dire que cela est le tour du joueur Black / Noir.   

### Autres champs    

**Champ 3:** "K" et "Q" Indique si le roi blanc peut faire un petit roque (King side) ou un grand roque (Queen Side).   
        "k" et "q" sont l'équivalent pour le roi noir.    

**Champ 4:** Une case comme "e4" si le joueur peut réaliser une prise en passant, ou "-" sinon    

**Champ 5:** Nombre de demi-tour depuis la dernière fois que un pion à bougé, ou qu'une pièce a été mangée   

**Champ 6:** Nombre de tour écoulé


## Fuzzer : Implementation de la grammaire    

La grammaire étant très particulière, j'ai préféré faire ma propre classe pour implementer ma grammaire, plutôt    
qu'étendre GncBaseGrammar. Sinon il était par exemple dur de limiter à 2 fous noir, ou de garder 8 cases par rangées   
lorsque l'on mele nombre de cases vides et pieces.    

Il me fallait cependant étendre un Fuzzer pour utiliser les méthodes habituels des Fuzzer, et des Runners.      
J'ai donc crée une classe MyFENFuzzer en package "Myg-Chess-Fuzzer" , puis après j'ai défini la méthode fuzz de ma   
classe.         

L'idée simple de ma méthode fuzz pour générer la 1er partie de la string qui est la plus dure est:   
- L'on remplace les espace par des nombres après, et non au début    
- L'on ajoute des pièces tant qu'il reste des exemplaires de cette pièce     
- Le caractère ' ' est aussi compté comme une pièce    

L'on peut tester le fuzzer avec   

```
fuzzer := MyFENFuzzer new.
fuzzer fuzz.
```

Le code de la méthode fuzz est le suivant. Notons que j'ai aussi crée une méthode "FENspaceToNumber: aString"   
qui remplace les espace par des nombres, mais son code étant plus simple je ne montre pas spécifiquement son code.            


```
fuzz
	
	|pieces exemplaire result remaining i value part1 part2 part3 part4 part5 part6|
	pieces := #(' ' ' ' ' ' ' ' ' ' ' ' 'r' 'n' 'b' 'q' 'k' 'p' 'R' 'N' 'B' 'Q' 'K' 'P').
	exemplaire := #(64 64 64 64 64 64 2 2 2 1 1 8 2 2 2 1 1 8) asOrderedCollection.
	remaining := 64.
	part1 := ''.
	"32 piece max, 64 cases"
	
	[ remaining > 0 ] whileTrue: [  
	     i := (1 to: pieces size) atRandom.
	     value := (exemplaire at: i).
	
	     value > 0 ifTrue: [  
		      exemplaire at: i put: value - 1.
		      part1 := part1 , (pieces at: i).
		
	         remaining := remaining -1.
	         (((remaining rem: 8) = 0 and: [remaining ~= 0]) and: [remaining ~= 64]) ifTrue:[part1 := part1 , '/'].
		      
		  ].
		
	].

   part1 := self FENspaceToNumber: part1.
   part2 := #('w' 'b') atRandom.
   part3 := #('KQkq' 'KQk' 'Qk' '-' 'kQK') atRandom.
   part4 := #('-' '-' '-' '-' '-' '-' '-' '-' 'a3' 'c3' 'f3' 'h3' 'b6' 'd6' 'g6') atRandom.
   i := (0 to: 70) atRandom.
   part5 := ((0 to: i) atRandom) asString.
   part6 := i asString.
   result := part1, ' ', part2, ' ', part3, ' ', part4, ' ', part5, ' ', part6.

  ^ result.

```

## Test Oracle    

Le but de l'exercice va être de trouver des erreurs à l'aide de chaines FEN.    

Pour cela l'on peut déjà faire un premier test simple, qui est de vérifier la bonne execution de la méthode avec un   
testOracle. Et cela eh bien uniquement avec 2-3 chaines réalisées par notre Fuzzer que nous avons déjà. Les mutations   
n'étant pas indispensable pour les testsOracle. On trouvera peut-être plus de bug avec les mutations juste.       

J'ai choisis de créer la classe MyFENOracle:     
	- Qui teste une classe ayant les fonctions "fromFENString: aString", "board" et "currentPlayer"   
	- Pour une chaine FEN donné lance une erreur décrivant pourquoi le test n'est pas conforme au testOracle, ou ne ne leve     
			pas d'erreur si le résultat est celui attendu.     
	- L' Oracle implémenté est un test Différentiel. La classe MyFENOracle parse la chaine, et compare le résultat qu'elle     
	        génère à celui fourni par la classe testé.    
	- Les tests effectués sont "Couleur joueur courant" "Couleur des pièces" "Id des pièces"      

En interne, pour faciliter les tests j'ai aussi crée une classe "MyFENBoard" qui comprend des messages comme "a4", et peut répondre   
par l'id de sa pièce, ou sa couleur.    


Je teste avec les commandes:   

```
fuzzer := MyFENFuzzer new.
oracle := MyFENOracle new.
oracle testedClass: MyChessGame.

r := PzBlockRunner on: [ :str |  (oracle realizeTest: str) ].

fuzzer run: r times: 100. 
```

L'implémentation de la fonction realizeTest de l'Oracle comprend 50 lignes.    
Vous pouvez allez voir le code de "MyFENOracle >> realizeTest: aFENString" via l'IDE pharo si vous le souhaitez.    


## Premier résultat     

Les premiers résultats ont été assez rapides. Sur 100 FEN au hasard, 100 étaient en echec.    
Je savais pourtant par mes tests unitaires que 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' était bien parsé.    
J'ai fais quelques vérification manuelles, en partant de cette chaine sans echec.   

Et j'ai pu remarquer l'erreur suivante dans le programme testé:   
- Si une ligne de l'échequier n'est pas soit 100% remplis, soit 100% vide, la classe testée crashe avec "Collections sizes do not match"    
ou "Instance of Character did not understand #substring".              

J'ai vérifié cela avec les commandes suivantes, l'on fait parser une chaine au programme testé, et l'on affiche le résultat sans  
Oracle. La deuxième commande crash, car 2 pions ont été remplacés par 2 espaces.   

```
MyChessGame fromFENString: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.
```

```
MyChessGame fromFENString: 'rnbqkbnr/pp2pppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.
```

## Fuzzer : Besoin d'une nouvelle Grammaire   

Après le 1er test où le programme testé a eu 100% de crash, il me fallait réaliser une grammaire spécifiquement faire pour éviter ce   
bug déjà connu. Et découvrir de nouveaux bugs. J'ai fais une nouvelle classe MyFENSimpleFuzzer, redéfinissant la méthode fuzz,    
mais qui évitera le bug repéré.       

Le principe est simple:    
- Generation de 8 lignes aleatoires   
- La ligne contient soit 8 pieces, soit est '8'    
- Ainsi, l'on peut éviter de déclencher le bug déjà connu du parser   

L'on peut vérifier le bon fonctionnement de ce fuzzer, en affichant les chaines générées.    

```
fuzzer := MyFENSimpleFuzzer new.
fuzzer fuzz.
```

Et l'on obtient un nouveau testOracle.    
Je l'ai testé, et j'obtiens 9% de succès avec celui ci.     

```
fuzzer := MyFENSimpleFuzzer new.
oracle := MyFENOracle new.
oracle testedClass: MyChessGame.

r := PzBlockRunner on: [ :str |  (oracle realizeTest: str) ].

fuzzer run: r times: 100. 
```

## Second résultat         

Après test avec la nouvelle grammaire, j'obtiens 9% de succes.   

Je me suis cependant demandé pourquoi j'obtenais autant d'échec, et je me suis dit que j'allais remplacer les parties 3 et    
4 de chaines comme "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" par "-" afin de faciliter le travail du parser...   

Mal m'en à pris, je suis tombé à 0% de succès.    
Donc j'ai fais quelques tests en modifiant ma grammaire. Et j'ai découverts les erreurs suivantes:    
- Pour la partie 3 de la chaine il faut que celle ci soit "KQkq", et non pas "KQk" "Qk" "-" "kQK" ou l'on recoit les   
Exceptions "Expected one of #($k $K $q $Q)" ou "Assertion failed".       
- Pour la partie 4 de la chaine, il faut que celle-ci soit à "-", et non pas "a3" "c3" "f3" "h3" ou l'on recoit l'exception    
"Expected one of (3 to: 6)"     

J'ai maintenant modifié la classe MyFENSimpleFuzzer pour toujours envoyer "KQkq" et "-", en plus d'avoir uniquement des lignes   
100% vides, 100% pleines, et donc maintenant j'obtiens un taux de succès de 100% avec mon Fuzzer, sur 100 chaines. Je rappelle    
que mon Test Oracle vérifie la couleur du joueur, l'id des pièces, et la couleur des pièces.      


## Fuzzer : Mutation Testing   


Généralement en Mutation Testing l'on souhaiterais générer des chaines correctes différentes, et des chaines incorrectes.   
Cependant je dispose déjà de pas mal de résultats. Et j'ai pu voir que si j'utilise un test différentiel pour les chaines    
ne provoquant pas de crash, j'ai 100% de réussite. En vérifiant couleur du joueur, type des pièces, couleurs des pièces.    

J'ai donc choisit finalement d'arreter de vérifier si le parsing est correct. Ce qu'il semble être. Et plutôt de me concentrer   
sur les cas d'erreurs. Ma nouvelle idée va être d'envoyer des chaines légèrement incorrects, et de voir si un crash est détecté.   
Mon test Oracle sera juste "Vérifier si cela crash bien". Je vais Utiliser PzBlockRunner, et considérer que rencontrer "SUCESS"   
indique un échec.     


Les mutations que j'ai choisis d'implémenter sont:   
- Ajouter une pièce sur une ligne de façon à dépasser la limite normale. Uniquement sur une ligne non vide.   
- Ajouter un 7éme champ    
- Enlever le dernier champ   
- Remplacer une pièce par "a"   

J'implémente le mutation fuzzing via ma classe MyFENMutationFuzzer qui redéfini PzFuzzer. Et qui défini les méthodes "fuzz" et     
"seed: aCorpus". La facon de réaliser les tests est la suivante. Mais attention, pour rappel on va attendre un crash. Et non    
une réussite.   

```
fuzzer := MyFENSimpleFuzzer new.
corpus := (1 to: 100) collect: [:e | fuzzer fuzz].

mutationFuzzer := MyFENMutationFuzzer new.
mutationFuzzer seed: corpus.

r := PzBlockRunner on: [ :e | MyChessGame fromFENString: e ].
mutationFuzzer run: r times: 100.
```

## Troisième résultat         

Lors du test de mutation fuzzing, j'ai fait exprès d'envoyer 100% de chaines incorrectes, et pourtant j'ai environ 25% de chaines   
parsés pour lesquelles aucune erreur n'est déclenchée. Ce qui est incorrect.        
     
Après plus d'analyse, j'ai trouvé le bug suivant:     
- Si l'on envoie une chaine FEN qui contient 7 champs au lieu de 6, la chaine est interprétée alors que celle ci est incorrecte   


# Resultats finaux

En conclusion, un total de 4 erreurs ont été repérées.   
      
A mon grand regret, le choix d'un Test Différentiel en Test Oracle au début n'a pas été payant. Car les couleurs du joueur, les    
types de pièces parsés, ou la couleur des pièces parsés étaient corrects. Mais en alternant envoie de chaines corrects et   
incorrects, j'ai donc trouvé les erreurs suivantes.     

Pour rappel une chaine FEN correct est    
     
rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1    

**Liste d'erreur:**    
- Si une ligne de l'échequier n'est pas soit 100% remplis, soit 100% vide, la classe testée crashe avec "Collections sizes do not match"    
ou "Instance of Character did not understand #substring".              
- Pour la partie 3 de la chaine il faut que celle ci soit "KQkq", et non pas "KQk" "Qk" "-" "kQK" ou l'on recoit les   
Exceptions "Expected one of #($k $K $q $Q)" ou "Assertion failed".       
- Pour la partie 4 de la chaine, il faut que celle-ci soit à "-", et non pas "a3" "c3" "f3" "h3" ou l'on recoit l'exception    
"Expected one of (3 to: 6)"     
- Si l'on envoie une chaine FEN qui contient 7 champs au lieu de 6, la chaine est interprétée alors que celle ci est incorrecte   
