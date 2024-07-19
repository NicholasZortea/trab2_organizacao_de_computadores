.data
matriz3d:#5 × 5 × 10
	#dimensao 0 
	#     0  1  2  3  4  5  6  7  8  9
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 1
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 2
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 3
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 4
	
	#dimensao 1 
	#     0  1  2  3  4  5  6  7  8  9
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 1
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 2
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 3
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 4
	
	#dimensao 2 
	#     0  1  2  3  4  5  6  7  8  9
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 1
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 2
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 3
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 4
	
	#dimensao 3 
	#     0  1  2  3  4  5  6  7  8  9
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 1
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 2
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 3
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 4
	
	#dimensao 4 
	#     0  1  2  3  4  5  6  7  8  9
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 1
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 2
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 3
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #linha 4
	
twodSize: .word 200 #a matriz 5X10 possui 200 bytes de tamanho
A137: .asciiz "O elemento na posicao da matriz 1,3,7 eh: "
A223: .asciiz "O elemento na posicao da matriz 2,2,3 eh: "
A148: .asciiz "O elemento na posicao da matriz 1,4,8 apos a soma eh: "
.text
#para esse programa compilar ele precisa do procedimentos_print.asm no mesmo diretorio e a opção assemble all files in directory deve estar marcada
#$s0 <- elemento da matriz na posicao 1,3,7
#$s1 <- elemento da matriz na posicao 2,2,3
#$s2 <- endereco do elemento da matriz na posicao 1,4,8
main:
	jal preenche_matriz
	jal printa_matriz
	
	#pega o valor da posicao 137
	la $a0, A137 #$a0 <- string
	jal printa_string #printa o conteudo de $a0
	addiu $a0, $zero, 7 #$a0 <- coluna 7
	addiu $a1, $zero, 3 #$a0 <- linha 3
	addiu $a2, $zero, 1 #$a0 <- dimensao 1
	jal calcula_endereco #$v0 <- endereco do elemento A 1,3,7
	lw $a0, 0($v0) #$a0 <- valor contido em A 1,3,7
	move $s0, $a0 #$s0 <- valor contido em A 1,3,7
	jal printa_inteiro
	jal printa_linha_vazia #printa uma quebra de linha 
	
	#pega o valor da posicao 223
	la $a0, A223 #$a0 <- string
	jal printa_string #printa o conteudo de $a0
	addiu $a0, $zero, 3 #$a0 <- coluna 3
	addiu $a1, $zero, 2 #$a0 <- linha 2
	addiu $a2, $zero, 2 #$a0 <- dimensao 2
	jal calcula_endereco #$v0 <- endereco do elemento A 2,2,3
	lw $a0, 0($v0) #$a0 <- valor contido em A 2,2,3
	move $s1, $a0 #$s1 <- valor contido em A 2,2,3
	jal printa_inteiro
	jal printa_linha_vazia #printa uma quebra de linha 
	
	#faz a soma
	addiu $a0, $zero, 8 #$a0 <- coluna 8
	addiu $a1, $zero, 4 #$a0 <- linha 4
	addiu $a2, $zero, 1 #$a0 <- dimensao 1
	jal calcula_endereco #$v0 <- endereco do elemento A 1,4,8
	move $s2, $v0 #$s2 <- endereco da posicao da matriz 1,4,8
	add $t0, $s0, $s1 #$t0 <- A1,3,7 + A2,2,3
	sw $t0, 0($s2) #endereco da posicao da matriz 1,4,8 <- A1,3,7 + A2,2,3
	
	la $a0, A148 #$a0 <- string
	jal printa_string #printa o conteudo de $a0
	lw $a0, 0($s2) #$a0 <- valor contido na posicao da matriz 1,4,8
	jal printa_inteiro #printa inteiro em $a0
	
	
	
	li $v0, 10 #$v0 <- servico para finalizar o programa
	syscall




#registradores
#$t0 <- vai ser a 'dimensao'
#$t1 <- linha
#$t2 <- coluna
#$t4 <- registrador temporario para verificacoes de branch
printa_matriz:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes
	sw $ra, 0($sp) #armazena registrador
	
	#corpo do procedimento
	move $t0, $zero #$t0 <- 0
	move $t3, $zero #$t3 <- 0
	
for_dimensao_print:
	move $t1, $zero #$t1 <- 0
	for_linha_print:
		move $t2, $zero #$t2 <- 0
		for_coluna_print:
			move $a0, $t2 #$a0 <- $t2 (coluna) x
			move $a1, $t1 #$a0 <- $t1 (linha) y
			move $a2, $t0 #$a0 <- $t1 (dimensao) z
			jal calcula_endereco #$v0 <- endereco da matriz i, j, k
			lw $a0, 0($v0) #$a0 <- matriz em i,j,k
			jal printa_inteiro #printa o valor contido em matriz em i,j,k
			jal printa_virgula_espaco #printa uma virgula seguida de um espaco
			
		for_coluna_incrementa_print:
			addiu $t2, $t2, 1 #$t1 <- $t1 + 1
		for_coluna_teste_print:
			seq $t4, $t2, 10 #$t4 <- 1 se $t2 == 10 se nao 0
			beq $t4, $zero, for_coluna_print #se $t4 for 0 signfica que o $t2 eh menor que 10 e portanto deve ir para o comeco do for
			jal printa_linha_vazia #printa linha vazia
	for_linha_incrementa_print:
		addiu $t1, $t1, 1 #$t1 <- $t1 + 1
	for_linha_teste_print:
		seq $t4, $t1, 5 #$t4 <- 1 se $t1 == 5 se nao 0
		beq $t4, $zero, for_linha_print #se $t4 for 0 signfica que o $t1 eh menor que 5 e portanto deve ir para o comeco do for
		jal printa_linha_vazia #printa linha vazia
for_dimensao_incrementa_print:
	addiu $t0, $t0, 1 #$t0 <- $t0 + 1
for_dimensao_teste_print:
	seq $t4, $t0, 5 #$t4 <- 1 se $t0 == 5 se nao 0
	beq $t4, $zero, for_dimensao_print #se $t4 for 0 signfica que o $t0 eh menor que 5 e portanto deve ir para o comeco do for
fim_print:		
	#epilogo
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

#procedimento para preencher a matriz com base na seguinte logica
#matriz na posicao i, j, k = i + j + k
#registradores
#$t0 <- vai ser a 'dimensao'
#$t1 <- linha
#$t2 <- coluna
#$t3 <- soma da dimensao + linha + coluna
#$t4 <- registrador temporario para verificacoes de branch
preenche_matriz:
	#prologo
	addiu $sp, $sp, -4 #aloca 4 bytes
	sw $ra, 0($sp) #armazena registrador
	
	#corpo do procedimento
	move $t0, $zero #$t0 <- 0
	move $t3, $zero #$t3 <- 0
	
for_dimensao:
	move $t1, $zero #$t1 <- 0
	for_linha:
		move $t2, $zero #$t2 <- 0
		for_coluna:
			add $t3, $t0, $t1 #$t3 <- $t0 + $t1 = dimensao + linha
			add $t3, $t3, $t2 #$t3 <- $t3 + $t2 = dimensao + linha + coluna
			
			move $a0, $t2 #$a0 <- $t2 (coluna) x
			move $a1, $t1 #$a0 <- $t1 (linha) y
			move $a2, $t0 #$a0 <- $t1 (dimensao) z
			jal calcula_endereco #$v0 <- endereco da matriz i, j, k
			sw $t3, 0($v0) #matriz em i,j,k = i+j+k
			
		for_coluna_incrementa:
			addiu $t2, $t2, 1 #$t1 <- $t1 + 1
		for_coluna_teste:
			seq $t4, $t2, 10 #$t4 <- 1 se $t2 == 10 se nao 0
			beq $t4, $zero, for_coluna #se $t4 for 0 signfica que o $t2 eh menor que 10 e portanto deve ir para o comeco do for
	for_linha_incrementa:
		addiu $t1, $t1, 1 #$t1 <- $t1 + 1
	for_linha_teste:
		seq $t4, $t1, 5 #$t4 <- 1 se $t1 == 5 se nao 0
		beq $t4, $zero, for_linha #se $t4 for 0 signfica que o $t1 eh menor que 5 e portanto deve ir para o comeco do for
for_dimensao_incrementa:
	addiu $t0, $t0, 1 #$t0 <- $t0 + 1
for_dimensao_teste:
	seq $t4, $t0, 5 #$t4 <- 1 se $t0 == 5 se nao 0
	beq $t4, $zero, for_dimensao #se $t4 for 0 signfica que o $t0 eh menor que 5 e portanto deve ir para o comeco do for
fim:		
	#epilogo
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra




#a formula para calcular o endereco efetivo sera a seguinte:
#(((linha fornecida * 10 + coluna fornecida) * 4) + (dimensao fornecida * tamanho em bytes da matriz 5x10)) + endereco base da matriz

#registradores de argumento
#$a0 <- coluna do numero x
#$a1 <- linha do numero y
#$a2 <- 'dimensao' do numero z

#registradores de logica
#$s0 <- endereco base da matriz 3d
#$s1 <- tamanho em bytes de uma matriz 5x10 de inteiros
#$s2 <- (linha fornecida * 10 + coluna fornecida) * 4
#$s3 <- dimensao fornecida * tamanho em bytes da matriz 5X10
#$v0 <- soma de $s2, $s3 e $s0 ou seja a posicao na memoria do valor solicitado

#pilha
#0($sp) <- $ra
#4($sp) <- $s0
#8($sp) <- $s1
#12($sp) <- $s2
#16($sp) <- $s3
calcula_endereco:
	#prologo
	addiu $sp, $sp -20 #abre 20 bytes na pilha
	sw $ra, 0($sp) #armazena o registrador na pilha
	sw $s0, 4($sp) #armazena o registrador na pilha
	sw $s1, 8($sp) #armazena o registrador na pilha
	sw $s2, 12($sp) #armazena o registrador na pilha
	sw $s3, 16($sp) #armazena o registrador na pilha
	
	#corpo do procedimento
	la $s0, matriz3d #$s0 <- endereco base da matriz
	la $s1, twodSize #$s1 <- endereco base da variavel global
	lw $s1, 0($s1) #$s1 <- valor da variavel global
	mul $s2, $a1, 10 #$s2 <- linha fornecida * 10
	mflo $s2 #$s2 <- valor da multiplicacao 
	add $s2, $s2, $a0 #$s2 <- linha fornecida * 10 + coluna fornecida
	sll $s2, $s2, 2 #$s2 <- (linha fornedia * 10 + coluna fornecida) * 4
	
	mul $s3, $a2, $s1 #$s3 <- dimensao fornecida * tamanho em bytes da matriz 5X10
	mflo $s3 #$s3 <- valor da multiplicacao
	
	add $v0, $s2, $s3 #$v0 <- (linha fornecida * 10 + coluna fornecida) * 4) + (dimensao fornecida * tamanho em bytes da matriz 5x10)
	add $v0, $v0, $s0, #$v0 <- endereco da posicao na matriz solicitado
	
	#epilogo
	lw $ra, 0($sp) #restaura o registrador na pilha
	lw $s0, 4($sp) #restaura o registrador na pilha
	lw $s1, 8($sp) #restaura o registrador na pilha
	lw $s2, 12($sp) #restaura o registrador na pilha
	lw $s3, 16($sp) #restaura o registrador na pilha
	addiu $sp, $sp, 20 #desaloca 20 bytes na pilha
	jr $ra #retorna ao procedimento chamador