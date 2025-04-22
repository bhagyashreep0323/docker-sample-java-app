pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = 'your_aws_account_id' // Replace with your AWS Account ID
        AWS_REGION = 'your_aws_region'         // e.g., 'us-east-1'
        IMAGE_REPO_NAME = 'java-webapp'
        IMAGE_TAG = 'latest'
        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        REPOSITORY_URI = "${ECR_REGISTRY}/${IMAGE_REPO_NAME}"
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
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
                        docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $REPOSITORY_URI:$IMAGE_TAG
                        docker push $REPOSITORY_URI:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker run -d --name java-webapp-container2 -p 8080:8080 $REPOSITORY_URI:$IMAGE_TAG'
            }
        }
    }
}
