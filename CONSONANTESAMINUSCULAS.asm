# Cambia las letras cosonantes a minusculas
# Objetivo: Pasar letras consonantes a minusculas
#Elaboro Cuevas Salgado Carlos

	.data
	
entrada: .asciiz "Por favor escribe una frace en Mayusculas: \n"
salida:  .asciiz "La frace en minusculas es: "
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
	beq $t1,'A',Nocambio    #Si lo que esta es una t1 es una vocal
	beq $t1,'E',Nocambio	#Si lo que esta es una t1 es una vocal
        beq $t1,'I',Nocambio    #Si lo que esta es una t1 es una vocal
        beq $t1,'O',Nocambio    #Si lo que esta es una t1 es una vocal
        beq $t1,'U',Nocambio    #Si lo que esta es una t1 es una vocal
        beq $t1,'\n',Nocambio   #Si lo que esta es una t1 es salto de linea
        addu $t1,$t1,32 	#Hace una suma para poder cambiar de vocal mayuscula a consonante minuscula
        
Nocambio:
	sb $t1,($t0)		#Se carga lo que tenga t1 en t0, guardando el valor
	addu $t0,$t0,1 		#Se incrementa en 1 a t0
	b Ciclo		        #salta a la etiqueta Ciclo 
	
	
Salida:			

	la $a0,letras 		#Se carga en a0 el mensaje de salida
	li $v0,4		#Se guarda en v0 un 4 para poder imprimir la cadena
	syscall			#Llama al sistema

	li $v0,10 		#Se carga en v0 elo valor de 10 para finalizae
	syscall			# Llama al sistema
