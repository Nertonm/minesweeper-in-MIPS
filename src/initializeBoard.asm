.include "macros.asm"
.globl startBoard
.eqv count_i $s1 
.eqv count_j $s2 

startBoard:
	save_context
	move $s0, $a0 	# Passing parametros to local register
  	li count_i, 0 	# i = 0
  	
  	begin_for_i_it:	# for (int i = 0; i < SIZE; ++i) {
  		li $t0, SIZE
  		bge count_i, $t0, end_for_i_it 
  		li count_j ,0 	# j = 0
  		begin_for_j_it:	# for (int j = 0; j < SIZE; ++j) {
  			li  $t0, SIZE
  			bge count_j, $t0, end_for_j_it 	# loop check
  			# This section provides the corect index to allocate 
  			sll $t0, count_i,  5 		# i*8
  			sll $t1, count_j , 2 		# j
  			add $t0, $t0, $t1
  			add $t0, $t0, $s0
  			# My guesses were true, i just mutiply after thus (count_i*2^3+count_j)*2^2
	  		li $t1, -2 	
  			sw $t1, 0($t0)			# board[i][j] = -2; // -2 means no bomb
  			addi count_j ,count_j ,1        # count_j++
  			j begin_for_j_it
  	end_for_j_it:
  		addi count_i, count_i, 1
  		j begin_for_i_it
  	end_for_i_it:	# Complete all loops
  		restore_context
  	jr $ra 
