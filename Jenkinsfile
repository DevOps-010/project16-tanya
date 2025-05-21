pipeline {
    agent any

    tools {
        maven 'Maven-3.9.9'   // Make sure Maven is also configured in Jenkins
        jdk 'JDK11'     // Use the exact name you gave in Global Tool Config
    }

    environment {
        SONARQUBE = 'SonarQube'  // The name you gave your SonarQube server config in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DevOps-010/project16-tanya.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
