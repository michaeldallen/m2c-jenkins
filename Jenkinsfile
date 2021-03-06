pipeline {
    agent { 
        dockerfile true
    }
    environment {
      REGISTRY = "michaeldallen/m2c-jenkins-${DPKG_ARCH}"
      REGISTRYCREDENTIALS = credentials("michaeldallen-at-dockerhub")

      DPKG_ARCH = sh (returnStdout: true, script: 'dpkg --print-architecture').trim()
      HOSTNAME = sh (returnStdout: true, script: 'hostname').trim()

    }
    stages {
        stage('init') {
            steps {
                slackSend color: 'good', message: "start ${JOB_NAME} on ${HOSTNAME}: https://github.com/michaeldallen/m2c-jenkins/commit/${GIT_COMMIT}"
            }
        }
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
                sh 'docker tag m2c-jenkins-${DPKG_ARCH} michaeldallen/m2c-jenkins-${DPKG_ARCH}'
                withDockerRegistry([ credentialsId: "michaeldallen-at-dockerhub", url: "" ]) {
                    sh 'docker push michaeldallen/m2c-jenkins-${DPKG_ARCH}'
                }
            }
        }
    }
    post {
        success {
            slackSend color: 'good', message: "finish on ${HOSTNAME}: success: ${JOB_NAME}"
        }
        failure {
            slackSend color: 'danger', message: "finish on ${HOSTNAME}: failure: finished ${JOB_NAME}"
        }
    }
}
