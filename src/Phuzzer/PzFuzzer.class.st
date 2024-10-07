Class {
	#name : 'PzFuzzer',
	#superclass : 'Object',
	#instVars : [
		'random'
	],
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'initialization' }
PzFuzzer >> initialize [

	super initialize.
	random := Random new
]

{ #category : 'running' }
PzFuzzer >> run: aRunner times: anInteger [ 
	
	^ (1 to: anInteger) collect: [ :i | self value: aRunner ]
]

{ #category : 'accessing' }
PzFuzzer >> value: aValuable [

	^ aValuable value: self fuzz
]
