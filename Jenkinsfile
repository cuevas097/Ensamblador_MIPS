pipeline {
    
    agent any
    
  environment {
    DC_VARCOMPROBAR = "0"
  }
    stages {
     
        stage('Prueba1'){
            steps{
                
                sh '''
                    echo env.DC_VARCOMPROBAR
                    Cadena=$(grep -o Carlos Triangulo.asm)
                    env.DC_VARCOMPROBAR = Cadena
                    echo $DC_VarComprobar
                    '''
            }
        }
    }
}
