.include "macros.asm"

.globl revealNeighboringCells

.eqv    row     $s1
.eqv    col     $s2
.eqv    sum     $s5
.eqv    auxrow  $s3
.eqv    auxcol  $s4

revealNeighboringCells:
	save_context
    	move    $s0, $a0
    	move    row, $a1
    	move    col, $a2
    	move    $s6, col
    	addi    auxrow, row, 1
    	addi    auxcol, col, 1
    	addi    col, col, -1
    	addi    row, row, -1
	loop1:
    		blt     row, $zero, endloop2
    		bge     row, SIZE, endloop1
        	bgt     row, auxrow, endloop2
    		loop2:
        		blt     col, $zero, aaa
       	 		bge     col, SIZE, endloop2
        		bgt     col, auxcol, endloop2
        		sll     $t5, row, 5
        		sll     $t6, col, 2
        		add     sum, $t5, $s0
        		add     sum, sum, $t6
        		lw      $t7, 0 (sum)
        		bne     $t7, -2, aaa
        		move    $a1, row
        		move    $a2, col
        		beqz	$t7, bbb
     			jal     countAdjacentBombs
        		sw      $v1, 0(sum)
        		lw 	$t8, 0 (sum)
        		beqz 	$t8, bbb  
	aaa:
        addi    col, col, 1
        j loop2
	bbb:
	move    $a1, row
        move    $a2, col
	jal	revealNeighboringCells
	addi    col, col, 1
        j loop2
	endloop2:
    	addi    row, row, 1
    	move    col, $s6
    	addi    col, col, -1
    	j loop1
	endloop1:
	restore_context
    	jr  $ra
