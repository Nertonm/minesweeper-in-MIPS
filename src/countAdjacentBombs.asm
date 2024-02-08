.include "macros.asm"

.globl countAdjacentBombs

.eqv 	row $s2 
.eqv 	col $s3
.eqv 	auxrow $s4
.eqv 	auxcol $s5
.eqv	count $s6

countAdjacentBombs:
	move count, $zero
	move row, $a0   
	move col, $a1   
	move auxrow, row
	move auxcol, col
	addi auxrow, auxrow 1
	addi auxcol, auxcol 1
	addi row, row -1
	addi col, col -1

	loop1:
		beq 	row, auxrow, endloop1		
		addi 	row, row, 1 		
				
		loop2:
			beq 	col, auxcol, loop2
			blt	col, $zero, aaa 
			bgt	col, SIZE, aaa
			blt	row, $zero, aaa 	
			bgt	row, SIZE, aaa
			sll 	$t0, col,  5 	
			sll 	$t1, row, 2 	
  			add 	$t0, $t0, $t1
			beq 	$t0, -1, countadd
			aaa: 
				addi 	col, col, 1
				j 	loop1

countadd:
	addi 	count, count, 1
	addi 	col, col, 1
	j 	loop1

endloop1:
	j	play2

endloop2:
	j	loop1