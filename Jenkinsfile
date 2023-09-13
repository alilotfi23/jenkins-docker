pipeline {

  agent any

  stages {
    stage("docker build") {
      steps {
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:v1.$BUILD_ID'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:latest'
      }
    }

    stage("push Image: DOCKERHUB") {
      steps {
        withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_password')]) {
          sh "docker login -u alilotfi -p ${docker_password}"
          sh 'docker image push alilotfi/$JOB_NAME:v1.$BUILD_ID'
          sh 'docker image push alilotfi/$JOB_NAME:latest'
          sh 'docker image rm $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:latest'
        }
      }
    }

    stage("Docker Container Deployment") {
      steps {
        sshagent(['Dev-server']) {
          sh "ssh -o StrictHostKeyChecking=no ubuntu@docker-Dev-node-ip-addr docker run -p 8585:80 -d --name jenkins alilotfi/jenkins-docker:latest"
        }
      }
    }
  }
}
