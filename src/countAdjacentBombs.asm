.include "macros.asm"

.globl countAdjacentBombs

.eqv 	row $s2 
.eqv 	col $s3
.eqv 	auxrow $s4
.eqv 	auxcol $s5
.eqv	count $s6

countAdjacentBombs:

	save_context
	move $s6, $zero
	move row, $a0   #  
	move col, $a1   #  
	move $s4, row
	move $s5, col
	addi $s4, $s4 1
	addi $s5, $s5 1
	addi row, row -1
	addi col, col -1

	loop1:
		beq row, $s4, endloop1		# checar se loop 1 acabou
		addi row, row, 1 		# atribui loop 2  = 0;
				
		loop2:
			beq col, $s4, endloop2
			move $t0, row
			move $t1, col
			sll $t0, col,  5 # i*8
			sll $t1, row, 2 # j
  			add $t0, $t0, $t1
  			add $t0, $t0, $s0
			li $t3, -1
			beq $t0, $t3, countadd
countinue:# loop2++;
	addi	count, count, 1

countadd:
	addi 	count, count, 1
	j 	countinue

endloop1:
	restore_context
	jr 	$ra

endloop2:
	addi 	row, row, 1