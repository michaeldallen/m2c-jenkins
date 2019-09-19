pipeline {
    agent { 
        dockerfile true
    }
    environment {
      REGISTRY = "michaeldallen/m2c-jenkins-amd64"
      REGISTRYCREDENTIALS = credentials("michaeldallen-at-dockerhub")

      DPKG_ARCH = sh (returnStdout: true, script: 'dpkg --print-architecture').trim()
      
    }
    stages {
        stage('sanity-check') {
            steps {
                sh 'id'
                sh 'pwd'
                sh 'env | sort'
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
                sh 'docker tag m2c-jenkins-amd64 michaeldallen/m2c-jenkins-amd64'
                sh 'echo docker tag m2c-jenkins-amd64 michaeldallen/m2c-jenkins-${DPKG_ARCH}'
                withDockerRegistry([ credentialsId: "michaeldallen-at-dockerhub", url: "" ]) {
                    sh 'docker push michaeldallen/m2c-jenkins-amd64'
                }
            }
        }
    }
}
