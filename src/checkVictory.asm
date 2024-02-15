.include "macros.asm"

.globl checkVictory
.eqv count_i $s1 
.eqv count_j $s2 

checkVictory:
	save_context
	li 	$v0, 1
	move 	$s0, $a0 	# Passing parametros to local register
  	li count_i, 0 	# i = 0
  	
  	begin_for_i_it:	# for (int i = 0; i < SIZE; ++i) {
  		bge count_i, SIZE, end_for_i_it 
  		li count_j ,0 			# j = 0
  		begin_for_j_it:			# for (int j = 0; j < SIZE; ++j) {
  			bge count_j, SIZE, end_for_j_it 	# loop check
  			sll 	$t0, count_i,  5 	
  			sll 	$t1, count_j , 2 		
  			add 	$t0, $t0, $t1
  			add 	$t0, $t0, $s0
  			lw 	$t1, 0($t0)			
  			beq 	$t1, -2, count
  			addi count_j ,count_j ,1        # count_j++
  			j begin_for_j_it
  	end_for_j_it:
  		addi count_i, count_i, 1
  		j begin_for_i_it
  	count:
  		move 	$v0, $zero
  	end_for_i_it:	# Complete all loops
  		restore_context
  		jr $ra 

