pipeline {
    agent any        
    environment {
        
    }
    
    stages {
        stage('Checkout') {
            steps {
              
                git url: 'https://github.com/Utkarsh1320/spring-boot-hello-world', branch: 'main'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'  
            }
            steps {
                sh 'mvn deploy'
            }
        }
    }
    
    post {
        failure {
            echo 'Build failed! Please check the logs.'
        }
        success {
            echo 'Build and Deployment successful!'
        }
    }
}
