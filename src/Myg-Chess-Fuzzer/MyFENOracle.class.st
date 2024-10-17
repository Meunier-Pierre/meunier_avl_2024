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

{ #category : 'as yet unclassified' }
MyFENOracle >> realizeTest: aFENString [
	"For a FEN throw an error with an explicative message, if difference are observed is the testedClass don't give the result expected by the testOracle"
	
	|myBoard testedGame testedBoard intermediate tab1 tab2 ind1 ind2 pos part errorPlayerColor errorPieceColor errorPieceType testedPlayerWhite testedContent msgError|.
	myBoard := MyFENBoard new.
	testedGame := testedClass fromFENString: aFENString.
	testedBoard := testedGame board.
	intermediate := self numberToSpace: aFENString.
	part := aFENString splitOn: (' ' at: 1).
	errorPlayerColor  := false.
	errorPieceColor := false.
	errorPieceType := false.
	
	tab1 := #('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h'). 
	tab2 := #('8' '7' '6' '5' '4' '3' '2' '1').
	
	"First: parsing the board"
	
	1 to: 71 do: [ :i |
		ind2 := (i / 9) asInteger + 1.
		ind1 := (i rem: 9).
		
		ind1 ~= 0 ifTrue:[
			pos := (tab1 at: ind1), (tab2 at: ind2).
			myBoard at: pos put: (intermediate at: i).
	    ].
	].

	myBoard isPlayerWhite: (part at: 2) = 'w'.
	
	"Second: The comparison"
	
	testedPlayerWhite := testedGame currentPlayer isWhite.
	
	testedPlayerWhite = myBoard isPlayerWhite ifFalse: [errorPlayerColor := true].
	
	tab1 do: [ :cord1 | 
		tab2 do: [ :cord2 |
			pos := cord1, cord2.
			testedContent := (testedBoard at: pos) contents.
	
			testedContent isNil ifTrue:[
				(myBoard idAt: pos) isNil ifFalse:[errorPieceType := true].
			]
		   ifFalse:[
			    testedContent id = (myBoard idAt: pos) ifFalse: [errorPieceType := true].
			    testedContent isWhite = (myBoard isWhiteAt: pos) ifFalse: [ errorPieceColor := true].
			].
		]	
	 ].

    msgError := ''.
    errorPlayerColor ifTrue: [msgError := msgError , 'Erreur couleur joueur.'].	
	 errorPieceColor ifTrue: [msgError := msgError , 'Erreur couleur pièce.'].
	 errorPieceType ifTrue: [msgError := msgError , 'Erreur type pièce.'].
	 msgError ~= '' ifTrue: [(Error new messageText: msgError) signal.].
	

]

{ #category : 'accessing' }
MyFENOracle >> testedClass: aGame [
	
	testedClass := aGame
]
