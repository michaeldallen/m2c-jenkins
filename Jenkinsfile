pipeline {
    agent { docker { image 'ubuntu:bionic' } }
    stages {
        stage('sanity-check') {
            steps {
                sh 'pwd'
                sh 'find . -name .git -prune -o -print'
            }
        }
    }
}
