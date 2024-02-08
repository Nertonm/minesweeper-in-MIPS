.include "macros.asm"

.globl play
.globl play2
.eqv bomb
.eqv 	row $s2 
.eqv 	col $s3

play:
	save_context
	move 	row, $a0  		#  Saving row to subroutine space
	move 	col, $a1  		#  Saving row to subroutine space 
	sll 	$t0, row, 5		#  Math for calculing the matrix space
	sll 	$t1, col, 2		#  Math for calculing the matrix space
	add 	$t2, $t0, $t1		#  Math for calculing the matrix space
	li 	$t3, -1	
	beq 	$t2, $t3, lost		# Actual bomb check 
	j	countAdjacentBombs
	play2:
	j 	continue		# If not bomb continue
	
	lost:			
		move 	$v0, $zero
	
	continue:
		restore_context
		jr 	$ra
	
