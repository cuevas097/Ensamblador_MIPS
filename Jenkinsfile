pipeline {
    
    agent any
    
    stages {
     
        stage('Prueba1'){
            steps{
                
                sh '''
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    echo $Cadena
                    '''
            }
        }
    }
}
