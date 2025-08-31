pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        TF_VERSION = "1.7.0"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SeshuNaga/DevopsInfraTerraform.git'
            }
        }

        stage('Init & Plan') {
            steps {
                withCredentials([aws(credentialsId: 'Aws',
                                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                        terraform init
                        terraform plan -out=tfplan
                    """
                }
            }
        }

        stage('Approval') {
            steps {
                input message: "Apply changes?", ok: "Yes, apply"
            }
        }

        stage('Apply') {
            steps {
                withCredentials([aws(credentialsId: 'Aws',
                                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh "terraform apply -auto-approve tfplan"
                }
            }
        }
    }
}
