pipeline {
    agent { docker { image 'python:3.5.1' } }
    stages {
        stage('sanity-check') {
            steps {
                sh 'pwd'
                sh 'find . -name .git -prune -o -print'
            }
        }
    }
}
