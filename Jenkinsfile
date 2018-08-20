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
                withCredentials([usernamePassword(credentialsId: 'docker_login', usernameVariable: 'login', passwordVariable: 'password')]) {
                    powershell 'docker login -u $login -p $password'
                    powershell 'docker build -t jreedie/windows_petclinic:latest -f Dockerfile-app .'
                    powershell 'docker push jreedie/windows_petclinic:latest'
                }
            }
        }

        stage('Deploy app') {
            agent { label 'master' }
            steps{
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}