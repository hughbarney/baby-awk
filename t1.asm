		LDA v1
		ADD v2
		SUB v3
		STA v1
		STA v2
		STA v3
		LDA v1
		OUT
		LDA v2
		OUT
		LDA v3
		OUT
		STP
v1 CONST 2
v2 CONST 3
v3 CONST 1
