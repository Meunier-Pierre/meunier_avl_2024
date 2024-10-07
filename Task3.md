
# Task 3: fuzzing, oracles and property based testing    


  
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


## Implementation de la grammaire    

La grammaire étant très particulière, j'ai préféré faire ma propre classe pour implementer ma grammaire, plutôt    
qu'étendre GncBaseGrammar. Sinon il était par exemple dur de limiter à 2 tours noir, de garder 8 cases par rangées   
lorsque l'on mele nombre et piece...    

Il me fallait cependant étendre un Fuzzer pour utiliser les méthodes habituels des Fuzzer, et des Runners.      
J'ai utilisé le code suivant, puis après j'ai redéfini la méthode fuzz.      

```
PzFuzzer subclass: #MyFENFuzzer 
   instanceVariableNames: ''
	classVariableNames: ''
	package: 'Myg-Chess-Fuzzer'.
```

L'idée simple de ma méthode fuzz pour générer la 1er partie de la string qui est la plus dure est:   
- L'on remplace les espace par des nombres après, et non au début    
- L'on ajoute des pièces tant qu'il reste des exemplaires    
- Le caractère ' ' est aussi compté comme une pièce    

Le code de la méthode fuzz est le suivant. Notons que j'ai aussi crée une méthode "FENspaceToNumber: aString"   
qui remplace les espace par des nombres, mais son code étant plus simple je n'ai pas fourni le dit code.    


```
fuzz
	
	|pieces exemplaire result remaining i value part1 part2 part3 part4 part5 part6|
	pieces := #(' ' ' ' ' ' ' ' ' ' ' ' 'r' 'n' 'b' 'q' 'k' 'p' 'R' 'N' 'B' 'Q' 'K' 'P').
	exemplaire := #(64 64 64 64 64 64 2 2 2 1 1 8 2 2 2 1 1 8) asOrderedCollection.
	remaining := 64.
	part1 := ''.
	"32 piece max, 64 cases"
	"Mettons 0 à 2 cases entre chaque piece"
	
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
   part3 := #('KQkq' 'KQk' 'Qk' '' 'kQK') atRandom.
   part4 := #('-' '-' '-' '-' '-' '-' '-' '-' 'a3' 'c3' 'f3' 'h3' 'b6' 'd6' 'g6') atRandom.
   i := (0 to: 70) atRandom.
   part5 := ((0 to: i) atRandom) asString.
   part6 := i asString.
   result := part1, ' ', part2, ' ', part3, ' ', part4, ' ', part5, ' ', part6.

  ^ result.

```
