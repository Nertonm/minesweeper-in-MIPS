.include "macros.asm"

.globl printBoard

printBoard:
	save_context
	move 	$s0, $a0
	move 	$s1, $a1
	li 	$v0, 11 
  	li 	$a0, 32 	# printf("    ");
  	syscall							
 	syscall
  	syscall
  	syscall
 
  	li $t0, 0
  	# This just print the row numbers
  	print_indice:			# for (int j = 0; j < SIZE; ++j)	
 		li 	$t1, SIZE			
 		bge 	$t0, $t1, continue
 		li 	$v0, 11 
 		li 	$a0, 32 	# print (' ')
  		syscall
  		
  		li 	$v0, 1		# print ('i')
  		move 	$a0, $t0 	# $t0 is printed			
  		syscall
  		
  		li 	$v0, 11
  		li 	$a0, 32 	# print (' ')
  		syscall				
  		
  		addi 	$t0, $t0, 1
  		j 	print_indice
  		
  	continue:
  	li 	$v0, 11
  	li 	$a0, 10 	# printf("\n");
  	syscall
    	
    	# Printing Blank Spaces
  	li 	$v0, 11
  	li 	$a0, 32 	# printf("   ");
  	syscall
  	syscall
  	syscall
  	syscall
   
  	li 	$t0, 0
  	
  	# Printing Vertical Lines
  	begin_for_j2_pb:		# for (int j = 0; j < SIZE; ++j)
  		li 	$t1, SIZE
  		bge 	$t0, $t1, end_for_j2_pb
  		li 	$v0, 11
  		li 	$a0, 95 	# printf("___");
  		syscall
  		syscall
  		syscall
  		addi 	$t0, $t0, 1
  		j 	begin_for_j2_pb
  	
  	end_for_j2_pb:
  		# printf("\n");
 		li 	$v0, 11
 		li 	$a0, 10 			
  		syscall
  		
  		li 	$t0, 0 		
  		
  	begin_for_i_pb:			# for (int i = 0; i < SIZE; ++i) {
  		li 	$t7, SIZE
  		bge 	$t0, $t7, end_for_i_pb
  	
  		li 	$v0, 1
  		move 	$a0, $t0 	# printf(i)
  		syscall
  		li 	$v0, 11
  		li 	$a0, 32 	#printf(" ")
  		syscall
		li 	$v0, 11
  		li 	$a0, 124 	# printf("|")
  		syscall
  		li 	$v0, 11
  		li 	$a0, 32 	# print(" ")
  		syscall
  		li 	$t1, 0
  		
  		begin_for_ji_pb:	# for (int j = 0; j < SIZE; ++j) {
  			li 	$t7, SIZE
  			bge 	$t1, $t7, newline
  			li 	$v0, 11
  			li 	$a0, 32 	# print(" ")
  			syscall
  	
  			# Novamente calculo da posição da matriz
			sll 	$t2, $t0, 5
			sll 	$t3, $t1, 2
			add 	$t4, $t2, $t3
			add 	$t3, $t4, $s0 		# Adcionando a pos na soma
			
			lw  	$t4, 0 ($t3)		# Carregando t4 do mapa
			li 	$t7, -1
			
			bne 	$t4, $t7, elseif_imt	# -1 não apresenta as bombas if (board[i][j] == -1 && showBombs) {
			beqz 	$s1, elseif_imt		
		
			li 	$v0, 11
  			li 	$a0, 42 		# print (*)
  			syscall
  		
  	j print_space
  	
	elseif_imt:
		blt 	$t4, $zero, print_jogodaveia	# else if (board[i][j] >= 0) {
		li 	$v0, 1
  		move 	$a0, $t4 		# printf(" %d ", board[i][j]); // Revealed cell
  		syscall					
  		j 	print_space  	
  
	# printf(#)	
	print_jogodaveia:
		li 	$v0, 11
  		li 	$a0, 35 									
  		syscall
  		
  	# printf(' ')
  	print_space:
  		li 	$v0, 11
  		li 	$a0, 32 									
  		syscall
  
  	addi 	$t1, $t1, 1 
  	j 	begin_for_ji_pb
  	newline:
  	# printf('\n')
  		li 	$v0, 11
  		li 	$a0, 10 									
  		syscall
  
  	addi 	$t0, $t0, 1 
  	j 	begin_for_i_pb
  	end_for_i_pb:
  
  	restore_context  
  	jr 	$ra
