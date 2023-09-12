pipeline {

    agent any

    stages {
         stage("docker build"){
             steps{
            sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:v1.$BUILD_ID'
            sh 'docker image tag $JOB_NAME:v1.$BUILD_ID alilotfi/$JOB_NAME:latest'
             }
         }
        stage("docker deploy"){
            steps{
                sh 'docker run -itd --name apache -p 9000:80 $JOB_NAME'
            }
        }
    }
}
