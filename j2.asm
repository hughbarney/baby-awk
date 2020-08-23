# this version uses the negated LDA as in the original SSEM
#
#
loop	LDA cnt # its negated
		STA cnt #
		LDA cnt # its positive
		OUT
		SUB one
		STA cnt
		JNZ loop
		STP
cnt CONST 10
one CONST 1

