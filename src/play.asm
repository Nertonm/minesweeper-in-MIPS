.include "macros.asm"

.globl play
.globl return
.eqv 	row $t0 
.eqv 	col $t1
.eqv	sum $t2

play:
	save_context
	move 	$s0, $a0
	sll 	row, $a1,  5 	
  	sll	col, $a2 , 2
  	add 	sum, col, row 	
  	add 	sum, sum, $s0
  	lw 	$t3, 0 (sum)
  	beq 	$t3, 0, return
	bne	$t3, -1, continue
		li	$v0, 0
		restore_context
		jr	$ra
		
	continue: 
	bne	$t3, -2, continue
	jal	countAdjacentBombs
	sw	$v1, (sum)
	bne 	$v1, $zero, aaa
	jal	revealNeighboringCells
	return:
	aaa:
	restore_context
	li 	$v0, 1
	jr 	$ra
