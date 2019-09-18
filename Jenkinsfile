pipeline {
    agent { 
        dockerfile true
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
                sh 'sudo apt-get install -y make'
                sh 'make docker.build'
            }
        }
    }
}
