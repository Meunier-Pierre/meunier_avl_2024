Class {
	#name : 'MyFENBoard',
	#superclass : 'Object',
	#instVars : [
		'board'
	],
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'accessing' }
MyFENBoard >> at: pos put: value [
	|tab1 tab2 ind1 ind2|
	
	tab1 := 'abcdefgh'.
	tab2 := '12345678'.
	
	ind1 := nil.
	ind2 := nil.
	
	1 to: 8 do: [ :e | 
		(tab1 at: e) = (pos at: 1) ifTrue: [ ind1 := e].
	].

	1 to: 8 do: [ :e | 
		(tab2 at: e) = (pos at: 2) ifTrue: [ ind2 := e].
	].

   Transcript show: 'ind1 est ', ind1; cr.
   Transcript show: 'ind2 est ', ind2; cr.
	
	(board at: ind1) at: ind2 put: value
]

{ #category : 'accessing' }
MyFENBoard >> idAt: pos [
	|tab1 tab2 ind1 ind2 tmp|
	tab1 := 'abcdefgh'.
	tab2 := '12345678'.
	ind1 := nil.
	ind2 := nil.
	
	1 to: 8 do: [ :e | 
		(tab1 at: e) = (pos at: 1) ifTrue: [ ind1 := e].
	].

	1 to: 8 do: [ :e | 
		(tab2 at: e) = (pos at: 2) ifTrue: [ ind2 := e].
	].
	
	tmp := (board at: ind1) at: ind2.
	tmp = (' ' at: 1) ifTrue: [^ nil] ifFalse: [ ^ tmp asLowercase ].
	
]

{ #category : 'initialization' }
MyFENBoard >> initialize [
	"create a board of 8 * 8"
	
	board := OrderedCollection new.
	
	1 to: 8 do:[:e| board add: (OrderedCollection new:8)].
]

{ #category : 'accessing' }
MyFENBoard >> isWhiteAt: pos [
	|tab1 tab2 ind1 ind2 tmp|
	tab1 := 'abcdefgh'.
	tab2 := '12345678'.
	ind1 := nil.
	ind2 := nil.
	
	1 to: 8 do: [ :e | 
		(tab1 at: e) = (pos at: 1) ifTrue: [ ind1 := e].
	].
	1 to: 8 do: [ :e | 
		(tab2 at: e) = (pos at: 2) ifTrue: [ ind2 := e].
	].
	
	tmp := (board at: ind1) at: ind2.
	tmp isNil ifTrue: [^ nil] ifFalse: [ ^ tmp isUppercase ].
]
