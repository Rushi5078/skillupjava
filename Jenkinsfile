pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9'  // Ensure Maven is configured in Jenkins
    }

    environment {
        IMAGE_NAME = 'skillup-java-app'      // Name of the Docker image
        CONTAINER_NAME = 'skillup-java-container'  // Container name
        PORT = '8080'  // Port to expose
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Rushi5078/skillupjava.git'
            }
        }

        stage('Build Application') {
            steps {
                script {
                    // Build the project using Maven
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Run the Docker container and map the port
                    sh "docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker resources...'
                sh 'docker system prune -f --volumes'
            }
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Check logs for details.'
        }
    }
}
