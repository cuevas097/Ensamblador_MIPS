# Cambia las letras Vocales a Mayusculas
# Objetivo: Pasar letras vocales a Mayusculas
#Elaboro Cuevas Salgado Carlos

	.data
	
entrada: .asciiz "Por favor escribe una frace en minusculas: \n"
salida:  .asciiz "La frace en mayusculas es: "
letras:  .space 20						# Se reserva espacio para la cadena de entrada

	.text
	.globl main
main:
        la $a0,entrada 		#Carga en a0 la direccion del mensaje de salida 
	li $v0,4		#Carga en v0 un para para imprimir una cadena
	syscall			#Llama al sistema

	la $a0,letras 		#Se carga en a0 el espacio reservado
	li $a1,20		#Se guarda en a1 el tamaño de la cadena
	li $v0,8 		#Se guarda en v0 el valor de 8 para lectura de cadena
	syscall			#Llama al sistema
	
	la $a0,salida 		#Carga en a0 la direccion del mensaje de salida 
	li $v0,4		#Carga en v0 un para para imprimir una cadena
	syscall			#Llama al sistema

	la $t0,letras		#Se carga donde se inicia la cadena

Ciclo:				
	lb $t1,($t0)		#Carga el en t1 lo que contiene el primer caracter de t0 en formato de ascii
	beqz $t1,Salida 	#Si lo que se tiene en t1 es 0, es decir NULL termina el ciclo   
	beq $t1,'a',Cambio      #Si lo que esta en t1 es una vocal salta a cambio
	beq $t1,'e',Cambio	#Si lo que esta en t1 es una vocal salta a cambio
        beq $t1,'i',Cambio      #Si lo que esta en t1 es una vocal salta a cambio
        beq $t1,'o',Cambio      #Si lo que esta en t1 es una vocal salta a cambio
        beq $t1,'u',Cambio      #Si lo que esta en t1 es una vocal salta a cambio
        j Nocambio              #Caso de no caer en ninguna de las opciones anteriores salta incondicionalmente a Nocambio
        
Cambio:	
        addu $t1,$t1,-32 	#Pasa de vocal minuscula a mayuscula

	
Nocambio:
	sb $t1,($t0)		#Se carga lo que tenga t1 en t0, guardando el valor
	addu $t0,$t0,1 		#Se incrementa en 1 a t0
	add $t3,$t3,1           #Se incrementa en 1 a t3
	b Ciclo		        #salta a la etiqueta Ciclo 
	
	
Salida:			

	la $a0,letras 		#Se carga en a0 el mensaje de salida
	li $v0,4		#Se guarda en v0 un 4 para poder imprimir la cadena
	syscall			#Llama al sistema

	li $v0,10 		#Se carga en v0 elo valor de 10 para finalizae
	syscall			# Llama al sistema