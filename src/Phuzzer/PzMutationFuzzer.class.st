Class {
	#name : 'PzMutationFuzzer',
	#superclass : 'PzFuzzer',
	#instVars : [
		'seed',
		'minMutations',
		'maxMutations',
		'mutations'
	],
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
PzMutationFuzzer >> fuzz [

	| mutationCandidate trials |
	mutationCandidate := seed at: (random nextInteger: seed size).
	trials := random nextIntegerBetween: minMutations and: maxMutations.
	trials timesRepeat: [ 
		mutationCandidate := self mutate: ( mutationCandidate) ].
	^ mutationCandidate
]

{ #category : 'initialization' }
PzMutationFuzzer >> initialize [

	super initialize.
	minMutations := 2.
	maxMutations := 10.
	mutations := {
		PzDeleteCharacterMutation new.
		PzInsertCharacterMutation new.
		PzFlipCharacterMutation new.
	}
]

{ #category : 'accessing' }
PzMutationFuzzer >> maxMutations [

	^ maxMutations
]

{ #category : 'accessing' }
PzMutationFuzzer >> maxMutations: anObject [

	maxMutations := anObject
]

{ #category : 'accessing' }
PzMutationFuzzer >> minMutations [

	^ minMutations
]

{ #category : 'accessing' }
PzMutationFuzzer >> minMutations: anObject [

	minMutations := anObject
]

{ #category : 'as yet unclassified' }
PzMutationFuzzer >> mutate: mutationCandidate [
	
	| mutationIndex mutation |
	mutationIndex := random nextInteger: mutations size.
	mutation := mutations at: mutationIndex.
	^ mutation mutate: mutationCandidate
]

{ #category : 'accessing' }
PzMutationFuzzer >> mutations [

	^ mutations
]

{ #category : 'accessing' }
PzMutationFuzzer >> mutations: anObject [

	mutations := anObject
]

{ #category : 'accessing' }
PzMutationFuzzer >> seed [

	^ seed
]

{ #category : 'accessing' }
PzMutationFuzzer >> seed: anObject [

	seed := anObject
]
