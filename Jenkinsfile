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
       stage('Build the application image'){
            steps {
                //Deploy
                script {
                    withCredentials([usernamePassword(credentialsId: '57785a38-2776-4ad8-8e80-1834ab7c7d85', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'sudo docker build -t rtapp:latest .'
                    }
                }
            }
       }
        stage('Deploy with Ansible') {
            steps {
                sh 'pwd'
                sh 'ls -l'
                sh 'ansible-playbook -i inventory.ini deploy-ansibl.yml'
            }
        }
}
}
