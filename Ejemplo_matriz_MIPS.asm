
.data
	
i:	.byte 0
l:	.byte 0
k:	.byte 0

m1:	.byte 2,2,2,2,1,1,1,1,1,1	# Reserva de espacio para matriz1 de 10*10
   	.byte 2,2,2,2,1,1,1,1,1,1
   	.byte 2,2,2,2,2,1,1,1,1,1
   	.byte 2,2,2,2,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1

m2:	.byte 1,2,2,2,1,1,1,1,1,1	# Reserva de espacio para matriz2 de 10*10
   	.byte 1,2,2,2,1,1,1,1,1,1
   	.byte 1,2,2,3,1,1,1,1,1,1
   	.byte 1,3,2,3,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1
   	.byte 1,1,1,1,1,1,1,1,1,1

m3: 	.byte 0,0,0,0,0,0,0,0,0,0	# Reserva de espacio para matriz3 de 10*10
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0
   	.byte 0,0,0,0,0,0,0,0,0,0

indm1:	.byte 0
indm2:	.byte 0
indm3:	.byte 0

me1:	.asciiz "\nNº de filas para la 1ª matriz (2<n<9): "
me2:	.asciiz "\nNº de columnas para la 1ª matriz (2<n<9): "
me3:	.asciiz "\nNº de filas para la 2ª matriz (2<n<9): "
me4:	.asciiz "\nNº de columnas para la 2ª matriz (2<n<9): "
men1:	.asciiz "\nMatriz resultado de la multiplicación: \n\n"	
men2:	.asciiz "\nNo coinciden el nº de columnas de m1 con el nº de filas de m2.\nVuelva a intentarlo\n"
blanco:	.asciiz "  "
salto:	.asciiz "\n"


.text
.globl main

main:


peticion:

	li $t8,2
	li $t9,9	

while1f:

	la $a0,me1		# Cadena "nº filas matriz 1:"
	li $v0,4
	syscall

	li $v0,5		# Lee nº de filas
	syscall	

	add $t1,$0,$v0		# Almacena el inmediato en t1
	blt $t1,$t8,volver1f	# Si t1<t8(=2) -> volver1f
	bgt $t1,$t9,volver1f	# si t1>t9(=9) -> volver1f
	
while1c:

	la $a0,me2		# Cadena "nº columnas matriz 1:"
	li $v0,4
	syscall

	li $v0,5		# Lee nº de columnas
	syscall	

	add $t2,$0,$v0		# Almacena el inmediato en t2
	blt $t2,$t8,volver1c	# Si t2<t8(=2) -> volver1c
	bgt $t2,$t9,volver1c	# si t2>t9(=9) -> volver1c

while2f:

	la $a0,me3		# Cadena "nº filas matriz 2:"
	li $v0,4
	syscall

	li $v0,5		# Lee nº de filas
	syscall	

	add $t3,$0,$v0		# Almacena el inmediato en t3
	blt $t3,$t8,volver2f	# Si t3<t8(=2) -> volver2f
	bgt $t3,$t9,volver2f	# si t3>t9(=9) -> volver2f

while2c:

	la $a0,me4		# Cadena "nº columnas matriz 2:"
	li $v0,4
	syscall

	li $v0,5		# Lee nº de columnas
	syscall	

	add $t4,$0,$v0		# Almacena el inmediato en t4
	blt $t4,$t8,volver2c	# Si t2<t8(=2) -> volver2c
	bgt $t4,$t9,volver2c	# si t2>t9(=9) -> volver2c

posible:

	bne $t2,$t3,error	# nº col m1 deben ser = nº filas m2
	sub $s0,$t1,1		# nº filas result = nº filas m1 - 1
	sub $s1,$t4,1		# nº colum result = nº colum m2 - 1

	sub $t1,$t1,1		# nfila1=fila1-1
	sub $t4,$t4,1		# ncol2=col2-1
	sub $t3,$t3,1		# nfila2=fila2-1

	lb $t5,i		# Carga i en t5
	lb $t6,l		# Carga l en t6
	lb $t7,k		# Carga k en t7

matriz1:

	bgt $t5,$t1,finm1	# Compara si i=nfila1, -> finm1 
	li $t6,0		# Inicializa l a 0

matriz2:

	bgt $t6,$t4,finm2	# Compara si l=ncol2, -> finm2
	li $t7,0		# Inicializa k=0

matriz3:

	bgt $t7,$t3,finm3	# Compara si k=nfila2, -> finm3
	
	jal calindm1		# Calcula el indice para m1
	jal calindm2		# Calcula el indice para m2
	jal calindm3		# Calcula el indice para m3
	lb $t0,m1($s2)		# Cargamos en t0 el nº apuntado por indm1
	lb $s5,m2($s3)		# Cargamos en s5 el nº apuntado por indm2
	
	mult $t0,$s5
	mflo $s5		# Guarda m1[t0]*[s5] en s5
	add $s6,$s6,$s5		# Guarda s6+s5 en s6
	sb $s6,m3($s4)		# Guarda el resultado en m3[indm3]

	add $t7,$t7,1		# Incrementa k=k+1

	j matriz3

finm3:

	add $t6,$t6,1		# Incrementa l=l+1
	li $s6,0		# Inicializa s6 a 0
	j matriz2

finm2:

	add $t5,$t5,1		# Incrementa i=i+1
	li $s6,0		# Inicializa s6 a 0
	j matriz1

finm1:

	j resultado

calindm1:

	li $t0,10		# Iniciaiza t0=10
	mult $t5,$t0		# Multiplica i*10=indm1
	mflo $s2		# Almacena indm1 en s2
	add $s2,$s2,$t7		# indm1=(i*10)+k
	jr $ra

calindm2:

	li $t0,10
	mult $t7,$t0
	mflo $s3
	add $s3,$s3,$t6		# indm2=(k*10)+j
	jr $ra

calindm3:

	li $t0,10
	mult $t5,$t0
	mflo $s4
	add $s4,$s4,$t6		# indm3=(i*10)+j
	jr $ra

resultado:
	
	la $a0,men1		# Cadena "Matriz resultado ..."
	li $v0,4
	syscall

	li $t5,0		# Inicializa i=0
	li $t6,0		# Inicializa l=0
	li $s4,0		# Inicializa indm3=0

filas:

	bgt $t5,$s0,fin		# Compara si i=nfilaresul -> fin 
	li $t6,0		# Inicializa l a 0
	
column:
	
	bgt $t6,$s1,fincol	# Compara si l=ncolumresul -> fincol
	
	jal calindm3		# Calcula el indice de la matriz3
	
	lb $s6,m3($s4)		# Cargamos en s6 el nº apuntado por indm3
	
	la $a0,blanco	        # Cadena " "
	li $v0,4
	syscall


	add $a0,$s6,$0		# Imprimo s6
	li $v0,1
	syscall

	add $t6,$t6,1		# Incremento el indice l
	
	j column		# Salto incondicional a column

fincol:

	la $a0,salto		# Cadena "\n"
	li $v0,4
	syscall


	add $t5,$t5,1		# Incremento indice i
	j filas			# Salto incondicional a filas

volver1f:

	j while1f		# Salta a etiqueta while1f

volver1c:

	j while1c		# Salta a etiqueta while1c

volver2f:

	j while2f		# Salta a etiqueta while2f

volver2c:
	
	j while2c		# Salta a etiqueta while2c

error:
	
	la $a0,men2		# Cadena "col m1<>fila m2.vuelve..."
	li $v0,4
	syscall

	j peticion		# Vuelve a la etiqueta peticion

fin:

	addi $v0,$0,10		# Fin del programa.
	syscall
