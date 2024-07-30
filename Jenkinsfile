pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "go-application-${env.GIT_COMMIT}"
        PATH = "${env.PATH}:/opt/go/bin"
    }

    stages {
        stage('Clean Previous Container') {
            steps {
                script {
                    def previousContainer = sh(script: "docker ps -q --filter name=go-application-", returnStdout: true).trim()
                    if (previousContainer) {
                        sh "docker rm -f ${previousContainer}"
                    }
                }
            }
        }
        stage('Compile Go Application') {
            steps {
                dir('app') {
                    sh 'export PATH=$PATH:/opt/go/bin && go build -o app-binary'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build(DOCKER_IMAGE, '-f Dockerfile .')
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p 4000:4000 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        cleanup {
            cleanWs()
        }
    }
}
