.data
.align 4
string1: .asciiz "Type a number: "
string2: .asciiz "Type another number: "
string3: .asciiz "Multiplication: "
.text
main:
	li $v0, 4
	la $a0, string1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 4
	la $a0, string2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	move $a1, $t0 # 1st parameter
	move $a2, $t1 # 2nd parameter
	jal multiplication
	j exit
	
multiplication:
	addi $sp, $sp, -20 # make space on 5 registers stack
	sw $ra, 16($sp) # register end return $ra
	sw $s3, 12($sp) # result
	sw $s2, 8($sp) # counter
	sw $s1, 4($sp) # 2nd arg
	sw $s0, 0($sp) #1st arg
	move $s0, $a1
	move $s1, $a2
	# counter
	move $s2, $s1 # 2nd param value
	for:
		beq $s2, $zero, functionEnd
		add $s3, $s3, $s0
		subi $s2, $s2, 1
		j for
	functionEnd:
		j print
		lw $s0, 0($sp) # restore $s0 on stack
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $s3, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20 # stack pointer
		j return
print:
	li $v0, 4
	la $a0, string3
	syscall
	li $v0, 1
	move $a0, $s3
	syscall
	j return
return:
	jr $ra
exit:
	li $v0, 10
	syscall