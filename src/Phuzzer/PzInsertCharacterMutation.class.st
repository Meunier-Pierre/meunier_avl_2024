Class {
	#name : 'PzInsertCharacterMutation',
	#superclass : 'Object',
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'mutating' }
PzInsertCharacterMutation >> mutate: aString [
	
	| index character |
	index := aString size atRandom.
	character := (32 to: 127) atRandom asCharacter.
	^ (aString copyFrom: 1 to: index), character asString, (aString copyFrom: index + 1 to: aString size)
]
