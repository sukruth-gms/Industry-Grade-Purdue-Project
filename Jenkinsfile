pipeline {
    agent any

    tools {
        maven 'maven'  // The name of the Maven installation in Jenkins
    }

    environment {
        IMAGE = 'rt-app-image'  // Replace with your actual image name
        DOCKER_USER = 'sukruth17'
        PASS = credentials('dockerhub-pass')
    }

    stages {
        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Build Image') {
            steps {
                script {
                    echo 'Building Docker IMAGE'
                    def buildNumber = env.BUILD_NUMBER
                    sh "docker build -t $IMAGE:$buildNumber ."
                }
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
