pipeline {
    agent any

    options {
        timeout(time: 20, unit: 'MINUTES')
    }

    tools {
        maven 'maven'
        jdk 'jdk17'
    }

    environment {
        SONARQUBE = 'SonarQube'
        DOCKER_HOST = 'unix:///var/run/docker.sock'
        IMAGE_NAME = 'tanya119/java-maven-app:latest'  // Change as needed
    }

    stages {
        stage('Checkout') {
            steps {
                // Clean workspace before checkout
                cleanWs()
                // Checkout code from Git
                git branch: 'main', // or 'master' depending on your default branch
                    url: 'https://github.com/DevOps-010/project16-tanya.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building project with Maven...'
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube static code analysis...'
                withSonarQubeEnv("${env.SONARQUBE}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo 'Waiting for SonarQube Quality Gate result...'
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Trivy Scan') {
            steps {
                echo 'Running Trivy security scan on Docker image...'
                sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL ${IMAGE_NAME}'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}


