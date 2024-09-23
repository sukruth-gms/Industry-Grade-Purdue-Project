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
                // Package the application
                sh 'mvn package'
            }
        }

        stage('Build the application image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-pass', usernameVariable: 'DOCKER_USER', passwordVariable: 'PASS')]) {
                        // Build the Docker image
                        sh '''
                            echo "Logging in to Docker Hub..."
                            echo $PASS | docker login -u $DOCKER_USER --password-stdin
                            echo "*** Tagging image ***"
                            docker tag $IMAGE:$BUILD_NUMBER $DOCKER_USER/$IMAGE:$BUILD_NUMBER
                            echo "*** Pushing image ***"
                            docker push $DOCKER_USER/$IMAGE:$BUILD_NUMBER
                        '''
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
