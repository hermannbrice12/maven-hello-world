pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials' // ID des credentials Docker Hub dans Jenkins
        DOCKER_IMAGE = 'tchofo/maven-hello-world'
        GITHUB_URL = 'https://github.com/hermannbrice12/maven-hello-world.git'
    }

    stages {
        stage('Clone') {
            steps {
                git url: "${GITHUB_URL}", branch: 'master'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Pousser l'image dans Docker Hub
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline terminé.'
        }
        success {
            echo 'Le pipeline a réussi.'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}
