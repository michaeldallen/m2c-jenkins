pipeline {
    agent any
    stages {
        stage('sanity-check') {
            steps {
                sh 'pwd'
                sh 'find . -name .git -prune -o -print'
            }
        }
        stage('build') {
            sh 'make docker.build'
        }
    }
}
