Class {
	#name : 'MyFENFuzzer',
	#superclass : 'PzFuzzer',
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'util' }
MyFENFuzzer >> FENspaceToNumber: aString [

	| size nbSpace result c |
	size := aString size.
	result := ''.
	nbSpace := 0.

	1 to: size do: [ :i |
		c := aString at: i.

		Character space = c
			ifTrue: [ nbSpace := nbSpace + 1 ]
			ifFalse: [
				result := (nbSpace = 0) ifTrue: [ result , (c asString) ]
					          ifFalse: [ result , (nbSpace asString) , (c asString) ].

				nbSpace := 0 ] ].

	nbSpace = 0 ifFalse: [ result := result , (nbSpace asString) ].

	^ result
]

{ #category : 'fuzzing' }
MyFENFuzzer >> fuzz [
	
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

]
