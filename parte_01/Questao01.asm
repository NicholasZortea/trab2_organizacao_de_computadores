.data
#variaveis globais g1 e g2
g1: .word 0 
g2: .word 0
g1_str: .asciiz " g1: "
g2_str: .asciiz " g2: "
inc1_str: .asciiz " inc1: "
inc2_str: .asciiz " inc2: "

.globl main
.text
#mapa dos registradores
#$s0 <- inc1
#$s1 <- inc2
#$s2 <- endereco de g1
#$s3 <- valor de g1
#$s4 <- endereco de g2
#$s5 <- valor de g2
main:
	#prologo
	#g1 = 10;
	#g2 = 10;
	la $s2, g1 #$s2 <- endereco de g1
	la $s4, g2 #$s4 <- endereco de g2
	addi $s3, $zero, 10 #$s3 <- 10
	addi $s5, $zero, 10 #$s5 <- 10
	sw $s3, 0($s2) #g1 <- 10
	sw $s5, 0($s4) #g2 <- 10
	
	#corpo do procedimento
	
	#primeiro printa os valores
	la $a0, g1_str
	jal printa_string
	move $a0, $s2
	jal printa_valor_em_endereco
	la $a0, g2_str
	jal printa_string
	move $a0, $s4
	jal printa_valor_em_endereco
	la $a0, inc1_str
	jal printa_string
	move $a0, $s0 #$a0 <- registradore que representa inc1
	jal printa_inteiro
	la $a0, inc2_str
	jal printa_string
	move $a0, $s1 #$a0 <- registradore que representa inc2
	jal printa_inteiro
	
	#inc1 = incrementa1(g1);
	move $a0, $s3 #$a0 <- valor de g1
	jal incrementa1 #$v0 <- g1 + 1
	move $s0, $v0 #$s0 <- $v0
	
	#inc2 = incrementa(&g2);
	move $a0, $s4 #$a0 <- endereco de g2
	jal incrementa2 #$v0 <- valor apontado pelo endereco de g2 + 1
	move $s1, $v0 #$s1 <- $v0
	
	#printa os valores apos execucao
	la $a0, g1_str
	jal printa_string
	move $a0, $s2
	jal printa_valor_em_endereco
	la $a0, g2_str
	jal printa_string
	move $a0, $s4
	jal printa_valor_em_endereco
	la $a0, inc1_str
	jal printa_string
	move $a0, $s0 #$a0 <- registradore que representa inc1
	jal printa_inteiro
	la $a0, inc2_str
	jal printa_string
	move $a0, $s1 #$a0 <- registradore que representa inc2
	jal printa_inteiro
	
	#epilogo
	li $v0, 10 #carrega servico de fim do programa em $v0
	syscall #finaliza o programa

#mapa dos registradores
#$a0 <- inteiro a ser incrementado em 1
#mapa da pilha
#0($sp) <- $ra
incrementa1:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes na pilha
	sw $ra, 0($sp) #armazena registrador de retorno
	
	#corpo do procedimento
	#x = x + 1;
	#return x;
	addi $v0, $a0, 1 #$v0 <- $a0 + 1
	
	#epilogo
	lw $ra, 0($sp) #restaura registrador de retorno
	addiu $sp, $sp, 4 #desaloca 4 bytes
	jr $ra #retorna ao procedimento chamador
	
#mapa dos registradores
#$a0 <- um endereco de memoria
#$s0 <- valor contido no endereco de memoria de $a0
#mapa da pilha
#0($sp) <- $ra
#4($sp) <- $s0
incrementa2:
	#prologo
	addiu $sp, $sp, -8 #aloca 8 bytes na pilha
	sw $ra, 0($sp) #armazena registrador de retorno
	sw $s0, 4($sp) #armazena registrador $s0
	
	#corpo do procedimento
	lw $s0, 0($a0) #$s0 <- valor contido no endereco de memoria armazenado em $a0
	addi $s0, $s0, 1 #$s0 <- valor + 1
	sw $s0, 0($a0) #endereco contido em $a0 <- valor + 1
	
	#return *y;
	move $v0, $s0 #$v0 <- valor + 1 a ser retornado
	
	#epilogo
	lw $ra, 0($sp) #restaura registrador de retorno
	lw $s0, 4($sp) #restaura registrador $s0
	addiu $sp, $sp, 8 #desaloca 8 bytes
	jr $ra #retorna ao procedimento chamador
	
#mapa dos registradores
#$a0 <- endereco de uma variavel global a ser printada 
#mapa da pilha
#0($sp) <- $ra
printa_valor_em_endereco:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes na pilha
	sw $ra, 0($sp) #armazena registrador de retorno
	
	#corpo do procedimento
	lw $a0, 0($a0) #$a0 <- endereco
	li $v0, 1 #servico para printar inteiro
	syscall	
	
	#epilogo
	lw $ra, 0($sp) #restaura registrador de retorno
	addiu $sp, $sp, 4 #desaloca 4 bytes
	jr $ra #retorna ao procedimento chamador

#mapa dos registradores
#$a0 <- endereco de uma string a ser printada 
#mapa da pilha
#0($sp) <- $ra	
printa_string:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes na pilha
	sw $ra, 0($sp) #armazena registrador de retorno
	
	#corpo do procedimento
	li $v0, 4 #servico para printar inteiro
	syscall	
	
	#epilogo
	lw $ra, 0($sp) #restaura registrador de retorno
	addiu $sp, $sp, 4 #desaloca 4 bytes
	jr $ra #retorna ao procedimento chamador
	
#mapa dos registradores
#$a0 <- int a ser printado 
#mapa da pilha
#0($sp) <- $ra	
printa_inteiro:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes na pilha
	sw $ra, 0($sp) #armazena registrador de retorno
	
	#corpo do procedimento
	li $v0, 1
	syscall 
	
	#epilogo
	lw $ra, 0($sp) #restaura registrador de retorno
	addiu $sp, $sp, 4 #desaloca 4 bytes
	jr $ra #retorna ao procedimento chamador
