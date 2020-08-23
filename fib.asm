# fibinanchi sequence

loop LDA v1
	ADD v2
	OUT
	STA temp
	LDA v2
	STA v1
	LDA temp
	STA v2
#	OUT v1
	# update loop count and check if done
	LDA count
	SUB one
	STA count
	JNZ loop
	STP

v1 CONST 0
v2 CONST 1
count CONST 10
temp CONST 0
one CONST 1
