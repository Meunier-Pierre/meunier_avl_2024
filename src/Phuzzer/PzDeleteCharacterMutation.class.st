Class {
	#name : 'PzDeleteCharacterMutation',
	#superclass : 'Object',
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'mutating' }
PzDeleteCharacterMutation >> mutate: aString [
	
	| index |
	index := aString size atRandom.
	^ (aString copyFrom: 1 to: index - 1), (aString copyFrom: index + 1 to: aString size)
]
