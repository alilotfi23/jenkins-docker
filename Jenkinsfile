pipeline {
  // Define the agent where the pipeline will run
  agent any

  stages {
    // Stage for building the Docker image
    stage("docker build") {
      steps {
        // Build the Docker image with a specific tag based on job name and build ID
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        
        // Tag the image with a versioned tag for Docker Hub
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:v1.$BUILD_ID'
        
        // Tag the image with the 'latest' tag for Docker Hub
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:latest'
      }
    }

    // Stage for pushing the Docker image to Docker Hub
    stage("push Image: DOCKERHUB") {
      steps {
        // Use stored credentials for Docker Hub login
        withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_password')]) {
          // Login to Docker Hub using the provided username and password
          sh "docker login -u alilotfi -p ${docker_password}"
          
          // Push the versioned image to Docker Hub
          sh 'docker image push alilotfi/$JOB_NAME:v1.$BUILD_ID'
          
          // Push the 'latest' tagged image to Docker Hub
          sh 'docker image push alilotfi/$JOB_NAME:latest'
          
          // Remove the local Docker images to free up space after pushing
          sh 'docker image rm $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:latest'
        }
      }
    }

    // Stage for deploying the Docker container
    stage("Docker Container Deployment") {
      steps {
        // Use SSH agent to connect to the remote server for deployment
        sshagent(['Dev-server']) {
          // Run the Docker container on the remote server with specified port mapping
          sh "ssh -o StrictHostKeyChecking=no ubuntu@docker-Dev-node-ip-addr docker run -p 8585:80 -d --name jenkins alilotfi/jenkins-docker:latest"
        }
      }
    }
  }
}
