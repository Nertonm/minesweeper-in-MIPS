.include "macros.asm"

.globl play

play:
	save_context
	move 	$s2, $a0  	#  Saving row to subroutine space
	move 	$s3, $a1  	#  Saving row to subroutine space 
	sll 	$t0, $s2, 5	#  Math for calculing the matrix space
	sll 	$t1, $s3, 2	#  Math for calculing the matrix space
	add 	$t2, $t0, $t1	#  Math for calculing the matrix space
	
	li 	$t3, -1	
	beq 	$t2, $t3, lost	# Actual bomb check 
	j 	continue	# If not bomb continue
	lost:			
		move 	$v0, $zero
	continue:
	restore_context
	jr 	$ra
	
