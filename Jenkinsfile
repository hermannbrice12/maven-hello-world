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
        
        stage('Build') {
            steps {
                script {
                    // Construire le projet Maven
                    sh 'mvn clean install'
                }
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    sh 'docker build -t maven-hello-world .'
                }
            }
        }
    }
}
