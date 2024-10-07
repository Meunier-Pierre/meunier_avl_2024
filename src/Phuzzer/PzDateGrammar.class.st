Class {
	#name : 'PzDateGrammar',
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
PzDateGrammar >> defineGrammar [ 

	super defineGrammar.
	
	ntDate
		--> ntDay, ntSeparator, ntMonth, ntSeparator, ntYear
		| ntMonth, ntSeparator, ntDay, ntSeparator, ntYear
		| ntYear, ntSeparator, ntMonth, ntSeparator, ntDay.
	ntSeparator --> '' | ' ' | '-' | ',' | '/'.
	ntDay --> ntNumber.
	ntMonth
		--> ntNumber
		| 'january' | 'January'
		| 'february' | 'February'.
	ntYear --> ntNumber.
	^ ntDate
]
