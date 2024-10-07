Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testMoves [
	
	| blackPawn squares board |
	board := MyChessBoard empty.
	board at: 'd5' put: (blackPawn := MyPawn black).

	squares := blackPawn legalTargetSquares.
	
	self assert: squares size equals: 1.
	self assert: ( squares includes: (board at: 'd4')).
]

{ #category : 'tests' }
MyPawnTests >> testMovesWithOponentObstacle [ 

	
	| whitePawn squares board |
	board := MyChessBoard empty.
	board at: 'd5' put: (whitePawn := MyPawn white).
	board at: 'd6' put: (MyRook black).

	squares := whitePawn legalTargetSquares.
	
	self assert: squares size equals: 0.
]
