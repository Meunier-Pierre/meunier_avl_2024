Class {
	#name : 'PzBlockRunner',
	#superclass : 'PzPharoRunner',
	#instVars : [
		'block'
	],
	#category : 'Phuzzer-Runners',
	#package : 'Phuzzer',
	#tag : 'Runners'
}

{ #category : 'instance creation' }
PzBlockRunner class >> on: aFullBlockClosure [

	^ self new
		  block: aFullBlockClosure;
		  yourself
]

{ #category : 'running' }
PzBlockRunner >> basicRunOn: input [

	^ block value: input
]

{ #category : 'accessing' }
PzBlockRunner >> block [

	^ block
]

{ #category : 'accessing' }
PzBlockRunner >> block: anObject [

	block := anObject
]
