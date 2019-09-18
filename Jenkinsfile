pipeline {
    agent { 
        dockerfile true
    }
    environment {
      REGISTRY = "michaeldallen/m2c-jenkins-amd64"
      REGISTRYCREDENTIALS = credentials("michaeldallen-at-dockerhub")

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
        stage('publish') {
            steps {
                withDockerRegistry([ credentialsId: "michaeldallen-at-dockerhub", url: "" ]) {
                    sh 'docker push michaeldallen/m2c-jenkins-amd64'
                }
            }
        }
    }
}
