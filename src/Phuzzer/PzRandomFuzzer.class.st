"
Produce strings of `minLength` to `maxLength` characters in the range \[`charStart`, `charStart` + `charRange`)
"
Class {
	#name : 'PzRandomFuzzer',
	#superclass : 'PzFuzzer',
	#instVars : [
		'minLength',
		'maxLength',
		'charStart',
		'charRange'
	],
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'accessing' }
PzRandomFuzzer >> charRange [

	^ charRange
]

{ #category : 'accessing' }
PzRandomFuzzer >> charRange: anObject [

	charRange := anObject
]

{ #category : 'accessing' }
PzRandomFuzzer >> charStart [

	^ charStart
]

{ #category : 'accessing' }
PzRandomFuzzer >> charStart: anObject [

	charStart := anObject
]

{ #category : 'as yet unclassified' }
PzRandomFuzzer >> fuzz [

	| stringLength |
	stringLength := random
		nextIntegerBetween: minLength
		and: maxLength + 1.

	^ String streamContents: [ :str |
		  stringLength timesRepeat: [
			  str nextPut: (random
					   nextIntegerBetween: charStart asciiValue
					   and: charStart asciiValue + charRange) asCharacter ] ]
]

{ #category : 'initialization' }
PzRandomFuzzer >> initialize [

	super initialize.
	minLength := 10.
	maxLength := 100.
	charStart := 32 asCharacter.
	charRange := 32.
]

{ #category : 'accessing' }
PzRandomFuzzer >> maxLength [

	^ maxLength
]

{ #category : 'accessing' }
PzRandomFuzzer >> maxLength: anObject [

	maxLength := anObject
]

{ #category : 'accessing' }
PzRandomFuzzer >> minLength [

	^ minLength
]

{ #category : 'accessing' }
PzRandomFuzzer >> minLength: anObject [

	minLength := anObject
]
