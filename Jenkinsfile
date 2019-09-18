pipeline {
    agent { 
        dockerfile true
    }
    environment {
      registry = "michaeldallen/m2c-jenkins-amd64"
      registryCredential = credentials("michaeldallen_at_dockerhub")

    }
    stages {
        stage('sanity-check') {
            steps {
                sh 'id'
                sh 'pwd'
                sh 'find . -name .git -prune -o -print'    
                sh 'make'
            }
        }
        
        stage('build') {
            steps {
                sh 'make docker.build'
            }
        }
    }
}
