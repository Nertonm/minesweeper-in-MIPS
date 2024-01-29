.include "macros.asm"
.data
	bomb:  	.asciiz " BombLoc: "
.globl plantBombs
.text

plantBombs:
	save_context
	move 	$s0, $a0	 	# Passing parametrer to local register
	li 	$a0, 0			# srand(time(NULL)); aux recebe 0
	li 	$a1, 8			# aux2 recebe 8
	li 	$s1, 0   		# i = 0
	
	loop:				#  for (int i = 0; i < BOMB_COUNT; ++i) {
	li 	$t0, BOMB_COUNT
	bge 	$s1, $t0, endloop 	# If t0 > s1 jumpp to end_for_i
	
		escolhednv:			# do {
		li 	$v0, 42		# 42 syscall Means random number
		syscall 
		
		move 	$s2, $a0  	# Moving the result of syscall to s2 row = rand() % SIZE;
		syscall			# Another random number syscall 
		move 	$s3, $a0  	# Now passing the value to s3 column = rand() % SIZE;
		sll 	$t0, $s2, 5	# Aha another time s2(row)*2^5
		sll 	$t1, $s3, 2	# collum * 2^2
		add 	$t2, $t0, $t1	# Now the sum
		add 	$t0, $t2, $s0	# Escolhendo o local onde vai ser implementado a bomba
		
		la $a0, bomb		
  		li $v0, 4 
		syscall
		
		move 	$a0, $t2
		li   	$v0, 1
		syscall
		
		lw 	$t1, 0 ($t0)	# Carrega em t1 os valores de t0
		li 	$t2, -1	
		beq 	$t2, $t1, escolhednv	#  Verifica se ja tem bomba while (board[row][column] == -1);
		sw 	$t2, 0 ($t0)	#  Bota a bomba board[row][column] = -1; // -1 means bomb present
		addi 	$s1, $s1, 1    	
		
	j 	loop
	endloop:
	restore_context
	jr 	$ra
