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
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Construction de l'image Docker à partir du Dockerfile
                    sh 'docker build -t maven-hello-world .'
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Exécution du conteneur à partir de l'image construite
                    sh 'docker run -d -p 8080:8080 --name maven-hello-world-container maven-hello-world'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Connexion à DockerHub (utilisation des credentials Jenkins pour DockerHub)
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                        // Connexion à DockerHub
                        sh 'echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
                        
                        // Taguer l'image avec l'identifiant DockerHub (tchofo)
                        sh 'docker tag maven-hello-world tchofo/maven-hello-world:latest'
                        
                        // Pousser l'image sur DockerHub
                        sh 'docker push tchofo/maven-hello-world:latest'
                    }
                }
            }
        }
    }
}
