Class {
	#name : 'MyFENOracle',
	#superclass : 'Object',
	#instVars : [
		'testedClass'
	],
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'parsing' }
MyFENOracle >> numberToSpace: aString [
	"For a string, return the same string but with the numbers remplaced by the 
	same number of space"
	
	|result|.
	result := ''.
	
	aString do: [:c | 
		($0 <= c and: c <= $9 )ifTrue:[
			1 to: (c asString asInteger) do:[:u|
				result := result, ' '.
			] 
		]
   		ifFalse:[result := result, c asString].
	].
	
	^ result.
	
	
	
	
    
]

{ #category : 'testing' }
MyFENOracle >> realizeTest: aFENString [
	"comment stating purpose of instance-side method"
	
	|myBoard testedGame testedBoard intermediate tab1 tab2 ind1 ind2 pos part ErrorPlayerColor ErrorPieceColor ErrorPieceType testedPlayerWhite|.
	myBoard := MyFENBoard new.
	testedGame := testedClass fromFENString: aFENString.
	intermediate := self numberToSpace: aFENString.
	part := aFENString splitOn: (' ' at: 1).
	ErrorPlayerColor  := false.
	ErrorPieceColor := false.
	ErrorPieceType := false.
	
	
	tab1 := #('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h'). 
	tab2 := #('1' '2' '3' '4' '5' '6' '7' '8').
	
	"First: parsing the board"
	1 to: 71 do: [ :i |
		ind1 := (i / 9) asInteger + 1.
		ind2 := (i rem: 9).
		
		ind2 ~= 0 ifTrue:[
			pos := (tab1 at: ind1), (tab2 at: ind2).
			myBoard at: pos put: (intermediate at: i).
	    ].
	].

	myBoard isPlayerWhite: (part at: 2) = 'w'.
	
	"Second: The comparison"
	
	testedPlayerWhite := testedGame currentPlayer isWhite.
	
	testedPlayerWhite = myBoard isPlayerWhite ifFalse: [ErrorPlayerColor := true].
	
	"TO DO: compare color piece + compare id piece + Throw Error if had error"	


	"(Error new messageText: 'a') signal."
]

{ #category : 'accessing' }
MyFENOracle >> testedClass: aGame [
	
	testedClass := aGame
]
