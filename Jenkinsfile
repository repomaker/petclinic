pipeline {
    agent { label 'windows-agent' }
    
    stages {

        stage('Build on Windows') {
            steps{
                powershell 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps{
                script{
                    docker.withRegistry('', 'docker_login'){
                        def customImage = docker.build("jreedie/windows_petclinic:latest", "-f Dockerfile-app .")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy app') {
            agent { label 'master' }
            sh 'terraform init'
            sh 'terraform apply -auto-approve'
        }
    }
}