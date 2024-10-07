Class {
	#name : 'PzGrammarFuzzer',
	#superclass : 'PzFuzzer',
	#instVars : [
		'grammar',
		'grammarGenerator'
	],
	#category : 'Phuzzer-Core',
	#package : 'Phuzzer',
	#tag : 'Core'
}

{ #category : 'instance creation' }
PzGrammarFuzzer class >> on: aGrammar [

	^ self new
		  grammar: aGrammar;
		  yourself
]

{ #category : 'initialization' }
PzGrammarFuzzer >> fuzz [

	^ grammar generate: grammarGenerator
]

{ #category : 'accessing' }
PzGrammarFuzzer >> grammar [

	^ grammar
]

{ #category : 'accessing' }
PzGrammarFuzzer >> grammar: anObject [

	grammar := anObject
]

{ #category : 'initialization' }
PzGrammarFuzzer >> initialize [
 
	super initialize.
	grammarGenerator := GncGrammarGenerator newMinimal.
	grammarGenerator maxHeight: 10.
	grammarGenerator maxSize: 10.
]
