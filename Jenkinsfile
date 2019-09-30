node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('SonarQube analysis') {
        def scannerHome = tool 'SonarQubeScanner';
        withSonarQubeEnv('Sonarqube') { // If you have configured more than one global server connection, you can specify its name
          sh "${scannerHome}/bin/sonar-scanner"
        }
    }


    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("siturrausach/mingeso-front")
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Deploy') {
        steps {
            echo 'Deploying'
        }
    }
}
