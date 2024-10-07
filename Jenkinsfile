pipeline { 
    agent any

    stages {
        stage('Clone') {
            steps {
                // Supprime le contenu de l'espace de travail
                sh 'rm -rf *'
                
                // Clone le projet depuis GitHub
                git 'https://github.com/hermannbrice12/maven-hello-world.git'
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Lancer les tests Maven dans le projet
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        success {
            echo 'Le pipeline a réussi avec succès !'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
