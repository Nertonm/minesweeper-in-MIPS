.include "macros.asm"

.globl play

play:
	li	$t0, 8 #Botando o numero de coisos no negoci 
	bne	 -1, 0 +($a0 * 8 + $a1)*4
# your code here
