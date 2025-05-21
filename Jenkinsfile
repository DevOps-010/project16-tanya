pipeline {
    agent any

    tools {
        maven 'maven'  // Ensure this matches Jenkins Global Tool config
        jdk 'jdk17'          // Ensure this matches Jenkins Global Tool config
    }

    environment {
        SONARQUBE = 'SonarQube'  // Name of your SonarQube server configured in Jenkins
        DOCKER_HOST = 'unix:///var/run/docker.sock'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                git credentialsId: 'github-pat', url: 'https://github.com/DevOps-010/project16-tanya.git', branch: 'main'
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
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}

