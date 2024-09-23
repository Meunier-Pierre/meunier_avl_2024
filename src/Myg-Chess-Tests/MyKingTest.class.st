Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testCanEatAttackerWhenInCheck [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'b3' put: (WhiteKing := MyKing white).
	board at: 'b4' put: (MyQueen black).

	squares := WhiteKing legalTargetSquares.
	self assert: ( squares includes: (board at: 'b4')).
]

{ #category : 'tests' }
MyKingTest >> testCanMoveOutOfCheck [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'e5' put: (WhiteKing := MyKing white).
	board at: 'g7' put: (MyBishop black).

	squares := WhiteKing legalTargetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( d5 d6 e4 e6 f4 f5) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyKingTest >> testCantMoveInCheck [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (WhiteKing := MyKing white).
	board at: 'd6' put: (MyRook black).
	board at: 'f7' put: (MyKing black).

	squares := WhiteKing legalTargetSquares.
	self assert: ( squares includes: (board at: 'd3')) not.
	
]

{ #category : 'tests' }
MyKingTest >> testCantStayInCheck [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (WhiteKing := MyKing white).
	board at: 'c5' put: (MyBishop black).
	board at: 'f7' put: (MyKing black).

	squares := WhiteKing legalTargetSquares.
	board.
	self assert: ( squares includes: (board at: 'd4')) not.
	self assert: ( squares includes: (board at: 'f2')) not.
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testMovesWhenNoDanger [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'd3' put: (WhiteKing := MyKing white).
	board at: 'b6' put: (MyRook black).
	board at: 'g6' put: (MyKnight black).

	squares := WhiteKing legalTargetSquares.
	
   self
		assertCollection: squares
		includesAll:
			(#( c2 c3 c4 d2 d4 e2 e3 e4 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyKingTest >> testNoMovesWhenCheckmate [

	| WhiteKing squares board |
	board := MyChessBoard empty.
	board at: 'd1' put: (WhiteKing := MyKing white).
	board at: 'c4' put: (MyRook black).
	board at: 'f2' put: (MyQueen black).

	squares := WhiteKing legalTargetSquares.
	self assert: ( squares size) equals: 0
]
