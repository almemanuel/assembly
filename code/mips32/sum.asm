.data
string1: .asciiz "First value: "
string2: .asciiz "Second value: "
string3: .asciiz "Sum value: "
.text
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
	
	add $t3, $t0, $t1
	
	li $v0, 4
	la $a0, string3
	syscall
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 10
	syscall
