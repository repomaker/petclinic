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
                withDockerRegistry([credentialsId: 'docker_login', url: '']){
                    powershell 'docker build -t jreedie/windows_petclinic:latest -f Dockerfile-app .'
                    powershell 'docker push jreedie/windows_petclinic:latest'
                }
            }
        }

        stage('Deploy app') {
            agent { label 'master' }
            steps{
                withCredentials([string(credentialsId: 'vault_token', variable: 'TOKEN')]) {
                    deployAzure '$TOKEN'
                }
            }
        }
    }
}