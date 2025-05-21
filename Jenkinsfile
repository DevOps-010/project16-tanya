pipeline {
    agent any

    tools {
        maven 'Maven-3.9.9'   // Ensure Maven is configured in Jenkins Global Tool Configuration
        jdk 'JDK11'           // Use the same name as configured in Jenkins Global Tool Configuration
    }

    environment {
        SONARQUBE = 'SonarQube'  // Jenkins SonarQube server name
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
                sh 'mvn clean install'
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
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}

