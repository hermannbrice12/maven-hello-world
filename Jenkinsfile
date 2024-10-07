pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                // Nettoyer l'environnement et cloner le projet
                sh 'rm -rf *'
                git 'https://github.com/hermannbrice12/maven-hello-world.git'
            }
        }
        stage('Build') {
            steps {
                // Exécuter le build Maven
                sh 'mvn clean install'
            }
        }
        stage('Run') {
            steps {
                // Exécuter l'application
                sh 'echo "Exécution du projet Maven"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès.'
        }
        failure {
            echo 'Il y a eu une erreur durant l\'exécution du pipeline.'
        }
    }
}
