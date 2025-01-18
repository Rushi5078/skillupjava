pipeline {
    agent any

    environment {
        IMAGE_NAME = 'skillup-java-app'      // Name of the Docker image
        CONTAINER_NAME = 'skillup-app-new'  // Name of the Docker container
        PORT = '8081'                       // External port for the application (mapped to container port 80)
        CONTAINER_PORT = '80'               // Internal port of the application inside the container
    }

    stages {
        stage('Clone Code') {
            steps {
                // Clone the repository that contains your skillup-java application code
                git branch: 'main', url: 'https://github.com/Rushi5078/skillupjava.git'
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
                    // Stop and remove any existing container with the same name
                    sh "docker rm -f ${CONTAINER_NAME} || true"

                    // Run the Docker container (map PORT to CONTAINER_PORT)
                    sh "docker run -d -p ${PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up Docker resources...'
                // Optional: clean up unused Docker resources
                sh 'docker system prune -f --volumes'
            }
        }
        success {
            script {
                echo 'Pipeline completed successfully!'
            }
        }
        failure {
            script {
                echo 'Pipeline failed. Please check the logs for more details.'
            }
        }
    }
}
