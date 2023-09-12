pipeline {

    agent any

    stages {

        stage("git login"){
            steps {
                git 'https://github.com/alilotfi23/Jenkins.git'
            }
        }
         stage("docker build"){
             steps{
            sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
             }
         }
    }
}
