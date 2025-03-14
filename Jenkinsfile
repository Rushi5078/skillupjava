pipeline {
    agent any

    environment {
        IMAGE_NAME = 'skillup-java-app'  // Docker image name
        CONTAINER_NAME = 'skillup-java-container'  // Container name
        HOST_PORT = '9090'  // Change this port to avoid conflict with Jenkins
        CONTAINER_PORT = '8786'  // Your application runs on this port inside the container
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
                    sh 'mvn clean install -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up unused Docker resources...'
                sh 'docker system prune -f --volumes'
            }
        }
        success {
            script {
                echo '✅ Deployment Successful! Access the application at http://localhost:9090'
            }
        }
        failure {
            script {
                echo '❌ Deployment Failed! Check logs for errors.'
                sh 'docker logs ${CONTAINER_NAME} || true'
            }
        }
    }
}
