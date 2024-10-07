Class {
	#name : 'MyKnightTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTests >> testIfCheckCanMoveToProtectKing [

	| whiteKnight squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (whiteKnight := MyKnight white).
	board at: 'b4' put: (MyKing white).
	board at: 'b7' put: (MyQueen black).
	board at: 'f8' put: (MyKing black).
	board at: 'g5' put: (MyPawn black).

	squares := whiteKnight legalTargetSquares.
	self assert: ( squares includes: (board at: 'b5')).

]

{ #category : 'tests' }
MyKnightTests >> testIfCheckCantMoveIfStayInCheck [

	| whiteKnight squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (whiteKnight := MyKnight white).
	board at: 'b4' put: (MyKing white).
	board at: 'b7' put: (MyQueen black).
	board at: 'f8' put: (MyKing black).
	board at: 'g5' put: (MyPawn black).

	squares := whiteKnight legalTargetSquares.
	self assert: ( squares includes: (board at: 'c8')) not. 
	self assert: ( squares includes: (board at: 'c4')) not. 
	self assert: ( squares includes: (board at: 'e4')) not. 
	self assert: ( squares includes: (board at: 'e8')) not. 
	self assert: ( squares includes: (board at: 'f7')) not. 
	self assert: ( squares includes: (board at: 'f5')) not. 

]

{ #category : 'tests' }
MyKnightTests >> testMovesAtBorder [
	

	| whiteKnight squares board |
	board := MyChessBoard empty.
	board at: 'd1' put: (whiteKnight := MyKnight white).

	squares := whiteKnight legalTargetSquares.
	
	self assert: squares size equals: 4.
	self assert: ( squares includes: (board at: 'b2')).
	self assert: ( squares includes: (board at: 'c3')).
	self assert: ( squares includes: (board at: 'e3')).
	self assert: ( squares includes: (board at: 'f2')).

	

]

{ #category : 'tests' }
MyKnightTests >> testMovesWithSameColorObstacle [ 

	| whiteKnight squares board |
	board := MyChessBoard empty.
	board at: 'e5' put: (whiteKnight := MyKnight white).
	board at: 'c6' put: (MyPawn white).
	

	squares := whiteKnight legalTargetSquares.
	
	self assert: squares size equals: 7.
	
	self
		assertCollection: squares
		includesAll:
			(#( d7 f7 g6 g4 f3 d3 c4 ) collect: [ :name |
				 board at: name ]).
]
