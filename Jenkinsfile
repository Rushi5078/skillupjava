pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-17'  // Uses Maven and Java 17
        }
    }

    environment {
        APP_NAME = "skillup-java-app"
        CONTAINER_NAME = "skillup-java-container"
        HOST_PORT = "8786"  // Changed from 8080 to avoid conflict with Jenkins
        CONTAINER_PORT = "8786"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Rushi5078/skillupjava.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $APP_NAME .'
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if running
                    sh 'docker rm -f $CONTAINER_NAME || true'

                    // Run new container on updated port 8786
                    sh 'docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $APP_NAME'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Access the application at http://localhost:8786"
        }
        failure {
            echo "❌ Deployment failed! Check logs for errors."
            sh 'docker logs $CONTAINER_NAME'
        }
    }
}
