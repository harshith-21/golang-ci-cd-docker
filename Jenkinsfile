pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "go-application-${env.GIT_COMMIT}"
        PATH = "${env.PATH}:/opt/go/bin"
        EXPOSED_SERVER_PORT = 4000
        HOST_NAME = "${env.HOSTNAME}"
        APP_URL = "${HOST_NAME}:${EXPOSED_SERVER_PORT}"
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
                    sh "docker build -t ${DOCKER_IMAGE} -f Dockerfile ."
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p ${EXPOSED_SERVER_PORT}:${EXPOSED_SERVER_PORT}--name ${DOCKER_IMAGE} ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            script {
                currentBuild.description = "Build details: <a href='${APP_URL}'>Click here</a>"
            }
        }
        cleanup {
            cleanWs()
        }
}
