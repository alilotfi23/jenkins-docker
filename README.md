# Jenkins-Docker

A simple CI/CD pipeline with Jenkins and Docker.

## BluePrint

![jen](https://github.com/alilotfi23/jenkins-docker/assets/91953142/ba509459-002a-4030-9989-d635dedecd9c)

## Introduction

This project demonstrates a simple Continuous Integration and Continuous Deployment (CI/CD) pipeline using Jenkins and Docker. The pipeline automates the process of building, testing, and deploying a Dockerized application.

## Pipeline Flow

1. **Developer Pushes Code:**
    - The developer pushes code changes to the Git repository.

2. **Jenkins Triggers Build:**
    - Jenkins is configured to monitor the Git repository for changes. When a new commit is detected, Jenkins triggers a new build.

3. **Pull Code:**
    - Jenkins pulls the latest code from the Git repository.

4. **Build Docker Image:**
    - Jenkins builds a new Docker image using the Dockerfile in the repository.

5. **Push Image to Docker Registry:**
    - The newly built Docker image is pushed to a registry (e.g., Docker Hub).

6. **Deploy to Development Environment:**
    - The Docker image is pulled from the registry and deployed to the development environment.

## Prerequisites

- Jenkins installed and configured.
- Docker installed on the Jenkins server and deployment server.
- Access to a Git repository.
- Docker registry account (e.g., Docker Hub).

## Setup Instructions

### Jenkins Configuration

1. **Install Necessary Plugins:**
    - Ensure Jenkins has the following plugins installed:
        - Git Plugin
        - Docker Pipeline Plugin

2. **Create a New Jenkins Pipeline:**
    - In Jenkins, create a new pipeline job.
    - Configure the pipeline to use the Jenkinsfile located in your repository.

### Docker Registry Configuration

1. **Create a Docker Hub Account:**
    - If you don't have one already, create an account on Docker Hub or any other Docker registry.

2. **Create a Repository:**
    - Create a new repository on Docker Hub to store your Docker images.

## Jenkinsfile

Create a `Jenkinsfile` in the root of your repository with the following content:

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://your-repo-url.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("your-dockerhub-username/your-repo-name")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy to Dev') {
            steps {
                script {
                    sh 'docker pull your-dockerhub-username/your-repo-name'
                    sh 'docker run -d -p 8080:80 your-dockerhub-username/your-repo-name'
                }
            }
        }
    }
}
```

### Environment Variables

Ensure you have configured the necessary environment variables in Jenkins for accessing your Git repository and Docker registry.

- `GIT_REPO_URL`: URL of your Git repository.
- `DOCKERHUB_USERNAME`: Your Docker Hub username.
- `DOCKERHUB_PASSWORD`: Your Docker Hub password or access token.

## Running the Pipeline

1. **Push Code Changes:**
    - Push changes to the Git repository to trigger the Jenkins pipeline.

2. **Monitor Jenkins:**
    - Monitor the Jenkins job to ensure the pipeline stages are executed successfully.

3. **Verify Deployment:**
    - Verify that the Docker container is running in the development environment.

## Conclusion

This CI/CD pipeline using Jenkins and Docker automates the process of building, testing, and deploying your application, ensuring a streamlined and efficient workflow.
