.data

max_iteracoes: .word 7
.text

main:
	li $a0, 2
	jal fatorial
	
	li $a0, 14
	li $a1, 2
	jal exponenciacao
	
	li $v0, 10
	syscall






#registradores
#$a0 <- numero fatorial
#$v0 <- produto de todos os numeros
#$s0 <- numero atual
fatorial:
	#prologo
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	move $v0, $a0 #$v0 <- numero inicial
	move $s0, $a0 #$s0 <- numero inicial
	
	#corpo do programa
	j verifica_condicao
	for:
	addiu $s0, $s0, -1 #$s0 <- $s0 - 1
	mul $v0, $v0, $s0 #$v0 <- $s0-1 * $v0
	verifica_condicao:
	bgt $s0, 1, for #se o valor atual for maior que 1 vai para o for 	
	
	#epilogo
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra

#registradores
#$s0 <- iteracao atual
#$s1 <- fatorial atual
#$s2 <- expoente atual
#$s3 <- valor exponenciado
#$s4 <- valor atual (x^expoente atual/fatorial (expoente atual)
#$s5 <- valor total
cos:
	#prologo
	addiu $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
	#corpo do programa
	addiu $s5, $zero, 1 #$s5 <- 1 inicializa a série de Taylor
	addiu $s0, $zero, 1 #$s0 <- 1 inicializa o contador
	
	for_Taylor:
	sll $s2, $s0, 1 #$s2 <- $s0 * 2 (iteracao atual * 2)
	
	move $a0, $s2 #$a0 <- $s2
	jal fatorial #$v0 <- fatorial de $s2
	move $s1, $v0 #$s1 <- fatorial atual(iteracao atual *2)
	
	
	verifica_for_Taylor:
	ble $s0, 7, for_Taylor #enquanto $s0 for menor ou igual a 7 vai para o for_Taylor
	
	
	#epilogo
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addiu $sp, $sp, 28
	jr $ra
	
#registradores 
#$a0 <- expoente
#$a1 <- valor a ser multiplicado
#$v0 <- valor total
#$s0 <- contador
exponenciacao:
	#prologo
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	#corpo do programa
	addiu $s0, $zero, 1 #$s0 <- 1
	move $v0, $a1 #$v0 <- valor a ser exponenciado
	j verifica_exp
	
	for_exp:
	mul $v0, $v0, $a1 #$v0 <- valor total * valor inicial
	addiu $s0, $s0, 1 #$s0 <- $s0 + 1
	
	verifica_exp:
	blt $s0, $a0, for_exp
	
	#epilogo
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	jr $ra