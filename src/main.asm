.include "macros.asm"

.data
	msg_row:  	.asciiz "Enter the row for the move: "
 	msg_column:  	.asciiz "Enter the column for the move: "
 	msg_win:  	.asciiz "Congratulations! You won!\n"
 	msg_lose:  	.asciiz "Oh no! You hit a bomb! Game over.\n"
	msg_invalid:    .asciiz "Invalid move. Please try again.\n"

.globl main 	 	

.eqv gameState $s1 		# 1 means active 0 means contray

.text
main:
	# sp means stack pointer and the next line make up space for the board 
  	addi $sp, $sp, -256 	#  why -256: its because of the 8*8 board times the 4 bits of data type  
  	li gameState, 1		# int gameActive = 1; $s1 hold the game state
  	move $s0, $sp
  	move $a0, $s0
  	jal startBoard 		# initializeBoard(board);
  	move $a0, $sp 				
  	jal plantBombs 		# placeBombs(board);
  		
  	gameActive:		# while (gameActive) {
  		beqz gameState, endGame
  		move $a0, $s0 	# passing $a0 as a parametrer 
  		li $a1, 0
  		jal printBoard	# printBoard(board,0); // Shows the board without bombs
  		# printf("Enter the row for the move: ");
  		la $a0, msg_row		
  		li $v0, 4 	#Syscall 4 means print						
  		syscall
  		li $v0, 5  	#Syscall 5 means scan	# scanf("%d", &row);
  		syscall
 		move $s2, $v0
		la $a0, msg_column
  		li $v0, 4 	# printf("Enter the column for the move: ");
  		syscall
  		li $v0, 5 	# scanf("%d", &column);
		syscall
		move $s3, $v0 
  
  		# Verification of the values selected
  		li $t0, SIZE
  		blt $s2, $zero, invalidMove	#if (row >= 0 && row < SIZE && column >= 0 && column < SIZE) {
  		bge $s2, $t0, invalidMove		
  		blt $s3, $zero, invalidMove
  		bge $s3, $t0, invalidMove
  		
  		# Passing board to subroutine play
  		addi $sp, $sp, -4
  		sw $s0, 0 ($sp)
  		move $a0, $s2
  		move $a1, $s3
  		jal play
  		addi $sp, $sp, 4
  		
  		# Check the game state 
  		bne $v0, $zero, continueGame 	# if (!play(board, row, column)) {
    		
    		# Lose Game
    			li gameState, 0		# gameActive = 0;
  			la $a0, msg_lose	# printf("Oh no! You hit a bomb! Game over.\n");
  			li $v0, 4
  			syscall
  			j gameLoop
  
 	continueGame:
 		move $a0, $s0
  		jal checkVictory		# else if (checkVictory(board)) {
  		# Expect to subroutine checkVictory state if the game is won
  		beq $v0, $zero, gameLoop	# if v0 is 0 continue gameLoop
  		la $a0, msg_win			# printf("Congratulations! You won!\n");
  		li $v0, 4
  		syscall
  		
  		# Reset the game state
  		li gameState, 0			# gameActive = 0; // Game ends
  		j gameLoop 
  	
  	invalidMove:		
  		la $a0, msg_invalid		# printf("Invalid move. Please try again.\n");
  		li $v0, 4
  		syscall
  	gameLoop:
  		j gameActive
  	
  	endGame:
  		move $a0, $s0 
  		li $a1, 1
  		jal printBoard			# printBoard(board,1);
  		li $v0, 10
  		syscall

