# this version uses the negated LDA as in the original SSEM
#
#
loop	LDA v1 # its negated
		STA v1 #
		LDA v1 # its positive
		OUT
		SUB v2
		CMP    # will skip jump if less than 0
		JMP fail
        OUT
		STP
fail 	LDA err
		OUT
		STP
v1 CONST 10
v2 CONST 11
err CONST 999 		

