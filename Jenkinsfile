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

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    // Get Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-pass', usernameVariable: 'DOCKER_USER', passwordVariable: 'PASS')]) {
                        def buildNumber = env.BUILD_NUMBER  // Ensure buildNumber is defined here
                        echo "Logging in to Docker Hub..."
                        sh "echo $PASS | docker login -u $DOCKER_USER --password-stdin"
                        echo "*** Tagging image ***"
                        sh "docker tag $IMAGE:$buildNumber $DOCKER_USER/$IMAGE:$buildNumber"
                        echo "*** Pushing image ***"
                        sh "docker push $DOCKER_USER/$IMAGE:$buildNumber"
                    }
                }
            }
        }
    }
}
