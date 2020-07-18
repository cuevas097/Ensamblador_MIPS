#Proyecto de Estructuras y programación de computadoras
#Autor: Cuevas Salgado Carlos
#Objetivo: Obtener la raiz cuadrada de un numero real mediante el metodo numerico de newton-raphson     
     .data
mensaje:       .asciiz "\tIntroduce un numero real:"     #Mensaje a usuario
mensaje2:      .asciiz "\n\tDesea ejecutar una vez mas el programa Si [1] | No [0]\n\t\t: "
mensaje3:      .asciiz "\n\tPrograma Finalizado."
tabulacion:    .asciiz "\t\t"
x:             .float 1.0                                #Valor inicial de x
constante:     .float 2.0                                #Constante que ayudara en la obtencio de la raiz cuadrada
zeroflotante:  .float 0.0                                #Valor auxiliar para hacer la comprativa entre flotantes
imaginario:    .asciiz "i\n"                             #En caso de ser numero imaginario se cargara la i
       .text
main:
       li $v0,4                  #Cargar en v0 el valor de 4 para imprimir una cadena
       la $a0,mensaje            #Carga la dirección de mensaje en a0
       syscall                   #Llamada al sistema
       
       li $v0,6                  #Carga en v0 el valor de 6 para leer un numero flotante, dicho valor se guarda en f0
       syscall                   #Llamada al sistema
       j Continuar               #Si ingresan un numero flotante ir a la etiqueta continuar
       j main                    #Si lo que ingresaron NO es numero real, se activa la exepcion y se regresa a esta linea para ir al main 

Continuar:       
       mov.s  $f1, $f0           #Coloco el valor de f0 en f1
       l.s    $f12, zeroflotante #Se mueve un cero flotante a f12
       move   $t0, $zero         #Bandera para saber si es imaginario 
       c.lt.s $f1,$f12           #Compara lo que esta en f1 es menor que zero    
       bc1t   Seguir             #Si es Menor que 0 saltara a la etiqueta Seguir para seguir normal el flujo del programa 
       addi   $t0,$t0,1         #Si es Mayor que 0 se le sumara un uno a la bandera t0

Seguir:       
       abs.s $f0, $f0            #Se saca el valor absoluto de f0
       l.s  $f1, x               #Guardando el valor de x en la variable f1
       l.s  $f3, x               #Guardando el valor de x en la variable f3
       l.s  $f2,constante        #Guardando el valor de la constante en la variable f2
       move $t1,$zero            #Se guarda el valor de 0 en la variable t1
hacer:
       mul.s $f1, $f1, $f1       #Se realiza la operacion x*x
       mul.s $f3, $f3, $f2       #Se realiza la operacion 2*x
       add.s $f1, $f1, $f0       #Se realiza la operacion (x*x) + N
       div.s $f1, $f1, $f3       #Se realiza la operacion ((x*x)+N )/2*x
       mov.s $f3, $f1            #Se guarda el NUEVO valor de x en f3
       add   $t1, $t1, 1         #Se hace un incremento en el contador
       blt   $t1, 10, hacer      #Mientras lo que tenga t1 sea diferente de 10 se hacer         
      
       la $a0,tabulacion	#Carga la dirección de mensaje en a0
       li $v0,4		        #Cargar en v0 el valor de 4 para imprimir una cadena
       syscall	                #Llamada al sistema
       
       mov.s $f12,$f1            #Mueve ek valor de f1 en f12 para poder imprimir el resultado
       li  $v0, 2                #Carga en v0 el valor de 2 para imprimir un numero flotante
       syscall                   #Llamada al sistema  
       
       beq $t0, 0, esImaginario  #Hace un comparacion si lo que tiene t0 es menor que 0 saltara a la etiqueta esImaginario
     
       j Regreso                #En caso contrario pasa a Regreso
           
esImaginario:
       la $a0,imaginario	#Carga la dirección de mensaje en a0
       li $v0,4		        #Cargar en v0 el valor de 4 para imprimir una cadena
       syscall	                #Llamada al sistema
       
Regreso:
       la $a0, mensaje2         #Carga la dirección de mensaje en a0
       li $v0, 4                #Cargar en v0 el valor de 4 para imprimir una cadena
       syscall                  #Llamada al sistema
      
       li   $v0, 5              #Carga en vo el valor de 10 para limpiar memoria
       syscall                  #Llamada al sistema
       
       move $t7, $v0            #Coloca el valor de v0 en t0
       beq  $t7, 1, main        #Hace la comparacion en caso de ser verdadera salta al main    
       
       li $v0,4                  #Cargar en v0 el valor de 4 para imprimir una cadena
       la $a0,mensaje3           #Carga la dirección de mensaje en a0
       syscall                   #Llamada al sistema
       
       li   $v0, 10              #Carga en vo el valor de 10 para limpiar memoria
       syscall                   #Llamada al sistema    
################################---CODIGO TOMADO DE LA DOCUMENTACION---########################################
   .ktext 0x80000180
   move $k0,$v0      #Guarda en k0 el valor de v0 en este caso un 6
   move $k1,$a0      #Guarda en k1 el valor de a0 en este caso mensaje
   la   $a0, msg     #Carga en a0 el mensaje de la excepción  
   li   $v0, 4       #Se guarda en v0 el valor de 4 para imprimir cadena
   syscall           #Llamada al sistema
   move $v0,$k0      #Regresa a v0 el valor guardado
   move $a0,$k1      #Regresa a 10 el valor guardado
   mfc0 $k0,$14      #Coprocessor 0 regristra $14 donde se tiene la direccion de la excepción. 
                     #Se utiliza 14 ya que esta establece la direccion donde se activo la excepción
   addi $k0,$k0,8    #Se le agregan 8 a k0 para ejecutar la segunda instruccion apartir de  donde se genero el error
   mtc0 $k0,$14      #Carga la nueva direccion en k0
   eret              #Retorna 
   .kdata	
msg:   
   .asciiz "\n\t  ERROR----INGRESE UN NUMERO REAL\n"
   
#################################---CODIGO TOMADO DE LA DOCUMENTACION---############################################

