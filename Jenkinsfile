pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '767397778787'
        AWS_REGION = 'ap-south-1'
        IMAGE_REPO_NAME = 'java-app'
        IMAGE_TAG = 'ver1'
        ECR_REGISTRY = "767397778787.dkr.ecr.ap-south-1.amazonaws.com"
        REPOSITORY_URI = "767397778787.dkr.ecr.ap-south-1.amazonaws.com/docker-img"
    }

    stages {

        stage('Check Docker Access') {
            steps {
                sh 'docker version'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} .'
            }
        }

       stage('Push Docker Image to ECR') {
    steps {
       
            sh '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
                docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
                docker push $REPOSITORY_URI:$IMAGE_TAG
            '''
        
    }
}

        stage('Deploy') {
            steps {
                sh 'docker run -d --name java-app-container1 -p 8081:8080 $REPOSITORY_URI:$IMAGE_TAG'
            }
        }
    }
}
