pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // ID des credentials Docker dans Jenkins
        DOCKER_IMAGE = 'tchofo/maven'  // Nom de l'image Docker
        GITHUB_CREDENTIALS_ID = 'github-credentials'  // ID des credentials GitHub dans Jenkins
        GIT_REPO = 'https://github.com/hermannbrice12/maven-hello-world.git'  // URL du dépôt GitHub
        GIT_BRANCH = 'main'  // Branche Git que vous souhaitez utiliser
        AWS_CREDENTIALS_ID = 'aws-credentials'  // ID des credentials AWS dans Jenkins
        AWS_REGION = 'us-east-3'  // Région AWS
        ECS_CLUSTER = 'your-ecs-cluster-name'  // Nom du cluster ECS
        ECS_SERVICE = 'your-ecs-service-name'  // Nom du service ECS
    }

    stages {
        stage('Checkout GitHub') {
            steps {
                git branch: "${GIT_BRANCH}", credentialsId: "${GITHUB_CREDENTIALS_ID}", url: "${GIT_REPO}"
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test Maven') {
            steps {
                withMaven(maven: 'Maven-Installation-maven') {
                    sh 'mvn test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Deploy to AWS ECS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${AWS_CREDENTIALS_ID}"]]) {
                    script {
                        sh """
                        aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
                        aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
                        aws configure set region ${AWS_REGION}

                        # Mise à jour de l'image Docker dans ECS
                        aws ecs update-service --cluster ${ECS_CLUSTER} --service ${ECS_SERVICE} --force-new-deployment
                        """
                    }
                }
            }
        }
    }
}
