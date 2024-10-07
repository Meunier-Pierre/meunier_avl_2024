Class {
	#name : 'PzPharoRunner',
	#superclass : 'PzRunner',
	#instVars : [
		'expectedException'
	],
	#category : 'Phuzzer-Runners',
	#package : 'Phuzzer',
	#tag : 'Runners'
}

{ #category : 'running' }
PzPharoRunner >> basicRunOn: input [

	self subclassResponsibility
]

{ #category : 'accessing' }
PzPharoRunner >> expectedException [

	^ expectedException
]

{ #category : 'accessing' }
PzPharoRunner >> expectedException: anObject [

	expectedException := anObject
]

{ #category : 'running' }
PzPharoRunner >> value: input [

	| result |
	[ result := self basicRunOn: input ]
		on: Error
		do: [ :err | 
			(expectedException notNil and: [ expectedException handles: err ])
				ifTrue: [ ^ self expectedFailureWith: {input . err freeze} ].
			^ self failureWith: {input . err freeze} ].
	^ self successWith: {input . result}
]
