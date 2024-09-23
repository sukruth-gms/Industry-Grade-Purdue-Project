pipeline {
    agent any
    
    tools {
        maven 'maven'  // The name of the Maven installation in Jenkins
    }
    
    stages {
        stage('Compile') {
            steps {
                // Build the application
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                sh 'mvn test'
            }
        }
       stage('Build') {
            steps {
                // Build
                sh 'mvn package'
        }
     }
}
}
