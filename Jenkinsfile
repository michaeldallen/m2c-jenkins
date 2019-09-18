pipeline {
    agent { 
        dockerfile true
    }
    environment {
      registry = "michaeldallen/m2c-jenkins-amd64"
      registryCredential = credentials('michaeldallen@dockerhub')

    }
    stages {
        stage('sanity-check') {
            steps {
                sh 'id'
                sh 'pwd'
                sh 'find . -name .git -prune -o -print'        
            }
        }
        
        stage('build') {
            steps {
                sh 'make'
                sh 'make docker.build'
            }
        }
    }
}
