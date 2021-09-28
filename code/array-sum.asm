.data 
.align 4
	arrayInt: .space 20 # 5 int -> 4B * 5 = 20B
	string0: .asciiz "Array with 5 positions\n"
	string1: .asciiz "Type a value for the position"
	string2: .asciiz ": "
.text
	li $v0, 4
	la $a0, string0
	syscall
	
	addi $t0, $zero, 5 # positions total
	add $t6, $zero, $zero # position counter
	la $t1, arrayInt
	add $t2, $zero, $zero # counter
	
	loopFeel:
		beq $t0, $t2, sumArray
		li $v0, 4
		la $a0, string1
		syscall
		
		li $v0, 1
		move $a0, $t6
		syscall
		
		li $v0, 4
		la $a0, string2
		syscall
		
		li $v0, 5
		syscall
		move $t3, $v0
		
		sw $t3, 0($t1) # stores the value in the array position
		addi $t1, $t1, 4 # increment to next array position
		addi $t2, $t2, 1 # increment loopFeel counter
		addi $t6, $t6, 1 # increment array position counter
		j loopFeel
sumArray:
	la $t4, arrayInt
	add $t7, $zero, $zero
	add $t5, $zero, $zero
	
		loopSum:
			beq $t0, $t5, printSum
			lw $s0, 0($t4)
			add $t7, $t7, $s0
			addi $t4, $t4, 4
			addi $t5, $t5, 1
			j loopSum
printSum:
	li, $v0, 1
	move $a0, $t7
	syscall
	j exit
exit:
	li $v0, 10
	syscall