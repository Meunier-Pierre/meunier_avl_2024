Class {
	#name : 'MyFENMutationFuzzer',
	#superclass : 'PzFuzzer',
	#instVars : [
		'corpus'
	],
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'fuzzing' }
MyFENMutationFuzzer >> fuzz [
	
	|fenString i|.
	fenString := corpus atRandom.
	
   i := #(1 2 3 4) atRandom.
    
   i = 1 ifTrue:[^ self oneMorePiece: fenString].
   i = 2 ifTrue: [ ^ self oneMoreField: fenString ].
   i = 3 ifTrue: [ ^ self oneLessField: fenString ].
	i = 4 ifTrue: [ ^ self onePieceToA: fenString ].
   
]

{ #category : 'fuzzing' }
MyFENMutationFuzzer >> oneLessField: fenString [ 
   "retrieve the last field of the fenString, so the number of turn"

	|parts lines inds chosen newPart1 result|.
   parts := fenString splitOn: ' '.
   result := (parts at: 1).

   2 to: 5 do:[:i | result := result , ' ' , (parts at: i) ].
	^ result.
]

{ #category : 'fuzzing' }
MyFENMutationFuzzer >> oneMoreField: fenString [ 
	"Add a 7th field to the FEN string"
   
   |added|.
   added := #('1' 'r' 'kQkQ' '@' '55' 'Hello') atRandom.
	^ fenString , ' ' , added.
]

{ #category : 'fuzzing' }
MyFENMutationFuzzer >> oneMorePiece: fenString [
   "Add one piece on a line at Random, to have 9 pieces on the line"
	
	|parts lines inds chosen newPart1 result|.
   parts := fenString splitOn: ' '.
   lines := (parts at: 1) splitOn: '/'.
   inds := OrderedCollection new.

   1 to: 7 do: [:i |
	    ((lines at: i) includes: $8) ifFalse: [ inds add: i].
	].

   inds size = 0 ifTrue: [^ fenString].

	chosen := inds atRandom.
	newPart1 := ''.
	
	1 to: 7 do:[:i |
		i = chosen ifTrue: [newPart1 := newPart1 , (lines at: i) , 'r/'] "Add a rook"
		ifFalse: [newPart1 := newPart1 , (lines at: i) , '/'].
	].

   newPart1 := newPart1, (lines at: 8).
	result := newPart1 , ' ' , (parts at: 2) , ' ' , (parts at: 3), ' ' , (parts at: 4), ' ' , (parts at: 5), ' ' , (parts at: 6).
	^ result.


]

{ #category : 'fuzzing' }
MyFENMutationFuzzer >> onePieceToA: fenString [ 
	"Switch one piece to the id A which doesn't exist"
	
	|parts lines inds chosen chosen2 newPart1 result|.
   parts := fenString splitOn: ' '.
   lines := (parts at: 1) splitOn: '/'.
   inds := OrderedCollection new.

   1 to: 7 do: [:i |
	    ((lines at: i) includes: $8) ifFalse: [ inds add: i].
	].

   inds size = 0 ifTrue: [^ fenString].

	chosen := inds atRandom.
	newPart1 := ''.
	
	1 to: 7 do:[:i |
		i = chosen ifTrue: [
			chosen2 := (1 to: (lines at: i) size) atRandom.
			Transcript show: 'chosen: ' , chosen asString , ' chosen2: ' , chosen2 asString; cr.
			1 to: (lines at: i) size do: [ :u | 
				u = chosen ifTrue: [newPart1 := newPart1 , 'a']
				ifFalse: [newPart1 := newPart1 , ((lines at: i) at: u) asString].
			].
			
			newPart1 := newPart1 , '/'.
		] "Add a rook"
		ifFalse: [newPart1 := newPart1 , (lines at: i) , '/'].
	].

   newPart1 := newPart1, (lines at: 8).
	result := newPart1 , ' ' , (parts at: 2) , ' ' , (parts at: 3), ' ' , (parts at: 4), ' ' , (parts at: 5), ' ' , (parts at: 6).
	^ result.
]

{ #category : 'accessing' }
MyFENMutationFuzzer >> seed: aCorpus [
	
	corpus := aCorpus
]
