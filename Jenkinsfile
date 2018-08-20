pipeline {
    agent { label 'windows-agent' }
    
    stages {

        stage('Build on Windows') {
            steps{
                powershell 'ls'
                powershell 'mvn --version'
            }
        }
    }
}