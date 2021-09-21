pipeline {
    
    agent any
    
  environment {
    DC_VarComprobar = "0"
  }
    stages {
     
        stage('Prueba1'){
            steps{
                
                sh '''
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    DC_VarComprobar = Cadena
                    echo $DC_VarComprobar
                    '''
            }
        }
    }
}
