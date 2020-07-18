# Cuenta el numero de ocurrencias de las letras
# Objetivo: Conteo de las apariciones de cada letra, espacio y otros simbolos, indicando el numero total de simbolos
#Elaboro Cuevas Salgado Carlos

################### Segmento de Datos o Data segment #####################
	.data
	
entrada: .asciiz "\nPor favor escribe una frace: "                #Frase de entrada 
Mensaje: .asciiz "\nLa letra: "                                   #Mensaje final
Mensaje2:.asciiz " su numero de ocurrencias es: "                 #Mensaje final2
Mensaje3: .asciiz "\nLos caracteres TOTALES que NO son letras ingresados" #Mensaje final3
letras:  .space 20 		                                          #Espacio reservado para la entrada
m2: .asciiz " "				# Se reserva espacio para auxiliarse en un futuro


################### Segmento de Codigos o Code segment #####################
	.text
	.globl main
main:
	la $a0,entrada 		# Carga en a0 la direccion del mensaje de salida 
	li $v0,4		# Carga en v0 un para para imprimir una cadena
	syscall			# Llama al sistema

	la $a0,letras 		#Se carga en a0 el espacio reservado
	li $a1,20		#Se guarda en a1 el tamaño de la cadena
	li $v0,8 		#Se guarda en v0 el valor de 8 para lectura de cadena
	syscall			# Llama al sistema

	la $t0,letras		# Se carga en t0 la direccion de letras
	move $t3,$zero          # Se guarda un 0 en t3 para poder realizar un conteo de cuantos careacter existen en total

Ciclo:				
	lb $t1,($t0)		# Carga el en t1 lo que contiene el primer caracter de t0 en formato de ascii
	beqz $t1,Seguir 	# Si lo que se tiene en t1 es 0, es decir NULL termina el ciclo
	blt $t1,'a',Nocambio    # Si lo que esta en t1 es menor que a salta
	bgt $t1,'z',Nocambio	# Si lo que esta en t1 es mayor que z salta
	addu $t1,$t1,-32 	# Se le resta para hacer el cambio de minusculas a mayusculas
Nocambio:
	sb $t1,($t0)		# Se carga lo que tenga t1 en t0, guardando el valor
	addu $t0,$t0,1 		# Se incrementa en 1 a t0
	add $t3,$t3,1           # Se incrementa en 1 a t3
	b Ciclo		        # salta a la etiqueta Ciclo 
	
Seguir:
        la $t0,letras		# Se carga en t0 la direccion de letras
        move $t5, $zero         # Se guarda en t5 un 0 para iniciar el contador
Ciclo2:				
	lb $t1,($t0)		# Carga el en t1 lo que contiene el primer caracter de t0 en formato de ascii 
	beqz $t1,Seguir2	# Si lo que se tiene en t1 es 0, es decir NULL termina el ciclo
	blt $t1,'A',NoEsLetra   # Si lo que esta en t1 es menor que A salta
	bgt $t1,'Z',NoEsLetra	# Si lo que esta en t1 es mayor que z salta
	sb $t1,($t0)		# Se carga lo que tenga t1 en t0, guardando el valor
	addu $t0,$t0,1 		# Se incrementa en 1 a t0
	b Ciclo2	        # salta a la etiqueta Ciclo 
				
NoEsLetra:
	add $t5,$t5,1           #Se incrementa en 1 el contador que inidicara cuantos caracteres que no son letras ingresaron
	sb $t1,($t0)            # Se carga lo que tenga t1 en t0, guardando el valor
	addu $t0,$t0,1          # Se incrementa en 1 a t0
	b Ciclo2	        # salta a la etiqueta Ciclo 
        	
Seguir2:
        la $a0,Mensaje3         #Se carga en a0 la direccion del mensaje 
	li $v0,4		# Se guarda en v0 el mensaje para imprimir el mensaje
	syscall	                #Llamada al sistema
        la $a0,Mensaje2         # Se carga en a0 la direccion del mensaje 
        li $v0,4                # Se guarda en v0 el mensaje para imprimir el mensaje
	syscall	                #Llamada al sistema
        move $a0, $t5           #Se mueve el valor de t5 en a0
        li $v0, 1               #Se carga el valor de 1 en v0 para poder imprimir
        syscall                 #Llamada al sistema
	
        move $t4, $zero         #Se inicializa en 0 la variable t4
        add $t4, $t4, 10        #Se le suma un salto de linea a t4
        move $t2, $zero         #Se inicializa en 0 la variable t2
        la $t0,letras		# Se carga en t0 la direccion de letras
 Regreso:
        move $t7,$zero          #Se inicializa el contador t7
        move $t6,$t0            #Se guarda la direccion inicia letras en t6
        lb $s0,($t0)            #Se carga el primer valor de la cadena en s0
        add $t6,$t6,1           #Se incrementa en 1 a t6
        add $t7,$t7,1           #Se incrementa en 1 a t7
        add $t2,$t2,1           #Se incrementa en 1 a t2
Inicio:
        addu $t0,$t0,1          #Se incrementa en 1 a t0
        lb $t1,($t0)            #Se carga el valor de t0 en t1
        beqz $t1,Imprimir       #En caso de que este vacia se imprime la cadena
        beq $t1,$s0,Aumento     #Se hace la comparacion si lo que esta en s0 es igual a t1 se hace un incremento
        j Inicio                #Salto incondicional a inicio
        
  Aumento:
        add $t7,$t7,1          #Se incrementa en 1 la variable t7
        sb $t4,($t0)           #Se guarda en t0 el valor de t4 en este caso un salto de linea
        j Inicio               #Salto incondicioal a inicio
 
 Imprimir: 
        beq $s0,$t4,CaracterEspecial     #Si lo que esta en s0 es un salto de linia salta a t4         

        la $a0,Mensaje 		# Se carga en a0 la direccion del mensaje 
        li $v0,4                # Se guarda en v0 el mensaje para imprimir el mensaje
	syscall	                #Llamada al sistema

        la $s1,m2               #Se carga en m2 una cadena vacia
        sb $s0,($s1)            #Se sustituye esa cadena vacia por el caracter a imprimir
        move $a0, $s1           #Se mueve lo que tiene s1 a a0 para poder imprimirlo
        li $v0, 4               # Se guarda en v0 el mensaje para imprimir el mensaje
	syscall	                #Llamada al sistema
        
        la $a0,Mensaje2         #Se carga en a0 la direccion del mensaje 
        li $v0,4                #Se guarda en v0 el mensaje para imprimir el mensaje
	syscall	                #Llamada al sistema
        
        move $a0, $t7          #Se pasa el valor de t7 a a0
        li $v0, 1              #Se coloca en v0 un 1 para poder imprimir un entero
        syscall                #Llamada al sistema

CaracterEspecial:             
        move $t0, $t6          #La variable t6 regresa a t0 el valor que habia guardado
        beq  $t2, $t3,Salida   #Salto a salida en caso de que ya no existan elementos a comparar
        j Regreso              #salto incondicional a Regreso


Salida:
	
	li $v0,10 		#Se carga en v0 elo valor de 10 para finalizae
	syscall			# Llama al sistema
