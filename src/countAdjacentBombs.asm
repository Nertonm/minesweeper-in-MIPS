.include "macros.asm"

.globl countAdjacentBombs

.eqv row $s2 # 1 means active 0 means contray
.eqv col $s3

countAdjacentBombs:

	save_context
	move $t4, $zero
	move $s2, $a0   #  
	move $s3, $a1   #  
	move $s4, $s2
	move $s5, $s3
	addi $s4, $s4 1
	addi $s5, $s5 1
	addi $s2, $s2 -1
	addi $s3, $s3 -1

	loop1:
	beq $s2, $s4, endloop1
	addi $s2, $s2, 1 # atribui loop 2  = 0;
	# checar se loop 1 acabou
	loop2:
	beq $s3, $s4, endloop2
	move $t0, $s2
	move $t1, $s3
	sll $t0, count_i,  5 # i*8
	sll $t1, count_j , 2 # j
  	add $t0, $t0, $t1
  	add $t0, $t0, $s0
	li $t3, -1
	beq $t0, $t3, count # Actual bomb check
countinue:
# loop2++;
# checar loop2 acabar



count:
addi $t4, $t4, 1
j countinue

restore_context
jr $ra