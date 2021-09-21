pipeline {
    
    agent any
    
    stages {
     
        stage('Prueba1'){
            steps{
                
                sh '''
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    NumeroHallazgos=${Cadena:1:2}
                    
                    echo $NumeroHallazgos
                    '''
            }
        }
    }
}
