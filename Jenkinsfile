pipeline {
    agent any

    environment {
        IMAGE_NAME = 'skillup-java-app'      // Name of the Docker image
        CONTAINER_NAME = 'skillup-app-new'  // Name of the Docker container
        PORT = '8081'    // Port for the application (mapped to 80 inside container)
    }

    stages {
        stage('Clone Code') {
            steps {
                // Clone the repository that contains your skillup-java application code
                git 'https://github.com/Rushi5078/skillupjava.git'
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

                    // Run the Docker container (expose it on port 8081)
                    sh "docker run -d -p ${PORT}:${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            // Optional: clean up Docker resources
            sh 'docker system prune -f'
        }
    }
}
