.include "macros.asm"

.globl play
#a1 coluna a0 linha
play:
	save_context
	#li	$t0, 8 #Botando o numero de coisos no negoclw 	$t0
	beg:
	sll	$t0, $a1, 8
	add	$t1, $t0, $a0
	sll	$t1, $t1, 2
	bne 	$t1, -1, lost
	restore_context
	j beg
	jr $ra
	#bne	 -1, 0 +($a0 * 8 + $a1)*4
# your code here
