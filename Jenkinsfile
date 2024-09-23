pipeline {
    agent any

    tools {
        maven 'maven'  // The name of the Maven installation in Jenkins
    }

    environment {
        IMAGE = 'rt-app-image'  // Replace with your actual image name
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
                        def buildNumber = env.BUILD_NUMBER
                        sh '''
                            echo "*** Building Docker image ***"
                            docker build -t $IMAGE:$buildNumber .
                            echo "Logging in to Docker Hub..."
                            echo $PASS | docker login -u $DOCKER_USER --password-stdin
                            echo "*** Tagging image ***"
                            docker tag $IMAGE:$buildNumber $DOCKER_USER/$IMAGE:$buildNumber
                            echo "*** Pushing image ***"
                            docker push $DOCKER_USER/$IMAGE:$buildNumber
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
