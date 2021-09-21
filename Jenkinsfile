pipeline {
    
    agent any
  
    stages {
     
        stage('Prueba1'){
            
           environment {
                    DC_VARCOMPROBAR = "0"
                }
            
            steps {
              echo "DC_VARCOMPROBAR = ${env.DC_VARCOMPROBAR}"
                
                sh '''
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    echo $Cadena
                    DC_VARCOMPROBAR = $Cadena
                    '''
               echo "$DC_VARCOMPROBAR"
            }
        }
    }
}
