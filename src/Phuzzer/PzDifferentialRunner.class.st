Class {
	#name : 'PzDifferentialRunner',
	#superclass : 'PzRunner',
	#instVars : [
		'runnerA',
		'runnerB',
		'comparator'
	],
	#category : 'Phuzzer-Runners',
	#package : 'Phuzzer',
	#tag : 'Runners'
}

{ #category : 'accessing' }
PzDifferentialRunner >> comparator [

	^ comparator
]

{ #category : 'accessing' }
PzDifferentialRunner >> comparator: anObject [

	comparator := anObject
]

{ #category : 'running' }
PzDifferentialRunner >> equals: resultA to: resultB [

	^ comparator value: resultA value: resultB
]

{ #category : 'running' }
PzDifferentialRunner >> initialize [

	super initialize.
	comparator := [ :a :b | a first = b first ].
]

{ #category : 'accessing' }
PzDifferentialRunner >> runnerA [

	^ runnerA
]

{ #category : 'accessing' }
PzDifferentialRunner >> runnerA: anObject [

	runnerA := anObject
]

{ #category : 'accessing' }
PzDifferentialRunner >> runnerB [

	^ runnerB
]

{ #category : 'accessing' }
PzDifferentialRunner >> runnerB: anObject [

	runnerB := anObject
]

{ #category : 'running' }
PzDifferentialRunner >> value: input [

	| resultA resultB |
	resultA := self runnerA value: input.
	resultB := self runnerB value: input.

	(self equals: resultA to: resultB) ifTrue: [ 
		^ self successWith: { input . resultA . resultB } ].
	^ self failureWith: {input . resultA . resultB}
]
