Class {
	#name : 'MyChessBoardTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessBoardTests >> testInitPieces [
	"To test if initializePiece which is private is correct, I call him with 
	 initPieces. And I check if the result is the same than if I init a Game with
	 fromFENString. So, DifferentialTesting "

	|board1 board2 game content1 content2 pos tab1 tab2|
	board1 := MyChessBoard initPieces.

	game := MyChessGame fromFENString: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'.
	board2 := game board.
	
	tab1 := #('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h'). "Because Pharo don't know the order of letters" 
	tab2 := #('1' '2' '3' '4' '5' '6' '7' '8').
	
	tab1 do: [ :cord1 | 
		tab2 do: [ :cord2 |
			pos := cord1, cord2.
			content1 := (board1 at: pos) contents.
			content2 := (board2 at: pos) contents.
	
			self assert: content1 isNil equals: content2 isNil.
			
			content1 ifNotNil: [ 
				self assert: content1 id equals: content2 id.
				self assert: content1 isWhite equals: content2 isWhite.
		   ]
		]	
	].
	
	self assert: MyBishop new id equals: 'B'
	

]
