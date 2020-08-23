# test baby add using subtract
#
		LDA v1  # its negated
		STA v1  # save it back
		LDA v1  # load it back not negated
		SUB v2
		STA v1
		OUT
		STP
v1 CONST 3
v2 CONST 2
