pipeline {
    agent { label 'windows-agent' }
    
    stages {

        stage('Build on Windows') {
            steps{
                powershell 'ls'
            }
        }

        stage('Build Docker Image') {
            steps{
                withDockerRegistry([credentialsId: 'docker_login', url: '']){
                    powershell 'docker build -t jreedie/windows_jnlp:latest -f Dockerfile-jnlp .'
                    powershell 'docker push jreedie/windows_jnlp:latest'
                }
            }
        }

        stage('Deploy app') {
            agent { label 'master' }
            steps{
                withCredentials([string(credentialsId: 'vault_token', variable: 'TOKEN')]) {
                    deployAzure 'invalid'
                }
            }
        }
    }
}