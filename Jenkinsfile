pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Packer Init') {
            steps {
                sh 'packer init packer/'
            }
        }

        stage('Packer Validate') {
            steps {
                sh 'packer validate packer/aws.pkr.hcl'
            }
        }

        stage('Build AMI') {
            steps {
                sh 'packer build packer/aws.pkr.hcl'
            }
        }
    }

    post {
        success {
            echo 'Golden AMI created successfully.'
        }

        failure {
            echo 'AMI build failed.'
        }
    }
}