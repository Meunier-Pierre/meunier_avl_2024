Class {
	#name : 'MyFENSimpleFuzzer',
	#superclass : 'PzFuzzer',
	#category : 'Myg-Chess-Fuzzer',
	#package : 'Myg-Chess-Fuzzer'
}

{ #category : 'fuzzing' }
MyFENSimpleFuzzer >> fuzz [
	
	| result lines part1 part2 part3 part4 part5 part6 pieces line|
	
	pieces := #('r' 'n' 'b' 'q' 'k' 'R' 'N' 'B' 'Q' 'K').
   lines := #('8' '8' '8' '8') asOrderedCollection .

   1 to: 4 do:[ :i |
		line := ''.
		1 to: 8 do: [ :u | line := line , (pieces atRandom) ].
	   lines add: line.
	].

   part1 := ''.
   1 to: 7 do: [ :u | part1 := part1 , (lines atRandom) , '/' ].
   part1 := part1 , (lines atRandom).

   part2 := #('w' 'b') atRandom.
   part3 := 'KQkq'.
   part4 := '-'.
   part5 := ((0 to: 5) atRandom) asString.
   part6 := ((0 to: 30) atRandom) asString.
   result := part1, ' ', part2, ' ', part3, ' ', part4, ' ', part5, ' ', part6.

  ^ result.


]
