pipeline {
    agent { dockerfile true }
  stages {

    stage('Deploy Image') {
      steps{
         script {
            dockerImage = docker.build("siturrausach/mingeso-front:latest")
            dockerImage.push()
         }
      }
    }

  }
}
