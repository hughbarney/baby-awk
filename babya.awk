# - assembler and interpreter for simple computer
#   usage: awk -f  program-file data-files...
#
# Manchester Small Scale Experiment Machine (SSEM)
# this version supports ADD and LDA does not negate on loading.

BEGIN {
	srcfile = ARGV[1]
	ARGV[1] = ""  # remaining files are data
	tempfile = ".temp"
	n = split("CONST GET OUT LDA STA SUB JNZ STP", x)
	for (i = 1; i <= n; i++)   # create table of op codes
		op[x[i]] = i-1
 
# ASSEMBLER PASS 1
	FS = "[ \t]+"
	while (getline <srcfile > 0) {
		sub(/#.*/, "")         # strip comments
		symtab[$1] = nextmem   # remember label location
#		print $1, nextmem
		if ($2 != "") {        # save op, addr if present
			print $2 "\t" $3 >tempfile
			nextmem++
		}
	}
	close(tempfile)
 
# ASSEMBLER PASS 2
	nextmem = 0
	while (getline <tempfile > 0) {
		if ($2 !~ /^[0-9]*$/)  # if symbolic addr,
			$2 = symtab[$2]    # replace by numeric value
		mem[nextmem++] = 1000 * op[$1] + $2  # pack into word
	}
 
# INTERPRETER
	for (pc = 0; pc >= 0; ) {
		addr = mem[pc] % 1000
		code = int(mem[pc++] / 1000)
		if      (code == op["GET"])  { db("GET",0,0); getline acc }
		else if (code == op["OUT"])  { db("OUT",addr,acc); print acc }
		else if (code == op["STA"])   { db("STA",addr,acc); mem[addr] = acc }
		else if (code == op["LDA"])   { db("LDA",addr,acc); acc  = -1 * mem[addr] }
#		else if (code == op["ADD"])  { db("ADD",addr,acc); acc += mem[addr] }
		else if (code == op["SUB"])  { db("SUB",addr,acc); acc -= mem[addr] }
		else if (code == op["JNZ"])   { db("JNZ",addr,acc); if (acc != 0) pc = addr }
		else if (code == op["STP"]) { db("STP",0,0); pc = -1 }
		else { db("ERROR",0); pc = -1 }
	}
}

function db(s1,s2,s3) {
	print s1,s2,s3
}
