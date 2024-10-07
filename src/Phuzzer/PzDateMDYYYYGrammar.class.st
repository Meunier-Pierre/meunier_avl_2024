Class {
	#name : 'PzDateMDYYYYGrammar',
	#superclass : 'GncBaseGrammar',
	#instVars : [
		'ntDate',
		'ntDay',
		'ntSeparator',
		'ntMonth',
		'ntYear'
	],
	#category : 'Phuzzer-Examples',
	#package : 'Phuzzer',
	#tag : 'Examples'
}

{ #category : 'initialization' }
PzDateMDYYYYGrammar >> defineGrammar [

	super defineGrammar.

	ntDate --> ntMonth , ntSeparator , ntDay , ntSeparator , ntYear.
	ntSeparator --> '-'.
	ntDay --> ntDigit | '1', ntDigit | '2', ntDigit | '30' | '31'.
	ntMonth --> ntDigit | '11' | '10' | '12'.
	ntYear --> ntDigit, ntDigit, ntDigit, ntDigit.
	^ ntDate
]
