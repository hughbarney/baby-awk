
loop	LDA cnt
		OUT
		SUB one
		STA cnt
		JNZ loop
		STP
cnt CONST 10
one CONST 1

