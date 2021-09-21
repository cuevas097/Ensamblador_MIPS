pipeline {
    
    agent any
  
    stages {
     
        stage('Prueba1'){
            steps{
                environment {
                    DC_VARCOMPROBAR = "0"
                }
                echo "DC_VARCOMPROBAR = ${env.DC_VARCOMPROBAR}"
                
                sh '''
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    echo $Cadena
                    '''
            }
        }
    }
}
