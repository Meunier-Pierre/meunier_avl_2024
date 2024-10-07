Class {
	#name : 'MyQueenTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTests >> testCantMoveIfKingInCheckAfter [ 

	| whiteQueen squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (whiteQueen := MyQueen white).
	board at: 'f2' put: (MyKing white).
	board at: 'c5' put: (MyBishop black).
	board at: 'g6' put: (MyKnight black).

	squares := whiteQueen legalTargetSquares.
	self assert: ( squares includes: (board at: 'e2')) not. 
	self assert: ( squares includes: (board at: 'd2')) not. 
	self assert: ( squares includes: (board at: 'd3')) not.
	self assert: ( squares includes: (board at: 'f3')) not.  
	self assert: ( squares includes: (board at: 'e4')) not.  
	self assert: ( squares includes: (board at: 'f4')) not.  
]

{ #category : 'tests' }
MyQueenTests >> testMovesWhenNoCheck [

	| whiteQueen squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (whiteQueen := MyQueen white).
	board at: 'f2' put: (MyKing white).
	board at: 'b5' put: (MyBishop black).
	board at: 'g6' put: (MyKnight black).

	squares := whiteQueen legalTargetSquares.
	
   self
		assertCollection: squares
		includesAll:
			(#( d3 b3 g3 e2 e5 e6 e8 c5 a7 c1 d2 g5 h6) collect: [ :name |
				 board at: name ])


]
