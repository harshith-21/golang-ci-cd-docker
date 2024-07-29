pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo 'Starting the build stage...'
                // Add your build steps here
            }
        }
        
        stage('Test') {
            steps {
                echo 'Hello'
                // Add your test steps here
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Starting the deploy stage...'
                // Add your deploy steps here
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
