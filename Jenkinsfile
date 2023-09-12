pipeline {

    agent any

    stages {
         stage("docker build"){
             steps{
            sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
             }
         }
    }
}
