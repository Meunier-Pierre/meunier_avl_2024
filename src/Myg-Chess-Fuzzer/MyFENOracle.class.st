Class {
	#name : 'MyFENOracle',
	#superclass : 'Object',
	#instVars : [
		'testedClass'
	],
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'parsing' }
MyFENOracle >> numberToSpace: aString [
	"For a string, return the same string but with the number remplaced by the 
	same number of space"
	
	|result|.
	
	result := ''.
	
	aString do: [:c | 
		($0 <= c and: c <= $9 )ifTrue:[
			1 to: (c asString asInteger + 1) do:[:u|
				result := result, ' '.
			] 
		]
   		ifFalse:[result := result, c asString].
	].
	
	^ result.
	
	
	
	
    
]

{ #category : 'accessing' }
MyFENOracle >> testedClass: aGame [
	
	testedClass := aGame
]
