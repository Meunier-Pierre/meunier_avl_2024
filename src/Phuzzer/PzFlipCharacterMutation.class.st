Class {
	#name : 'PzFlipCharacterMutation',
	#superclass : 'Object',
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'mutating' }
PzFlipCharacterMutation >> mutate: aString [ 
	
	| index character mutatedCharacter |
	index := aString size atRandom.
	character := aString at: index.
	mutatedCharacter := (character asInteger bitXor: 1 << (7 atRandom - 1)) asCharacter.
	^ aString copy
		at: index put: mutatedCharacter;
		yourself 
]
