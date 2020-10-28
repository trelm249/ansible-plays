pipeline {
  agent {
    docker {
      image 'trelm249/pimolecule:20201026'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  stages {

    stage ('Display versions') {
      steps {
        sh '''
          docker -v
          python3 -V
          ansible --version
          molecule --version
        '''
      }
    }

    stage ('Molecule test') {
      steps {
       // sh 'sudo molecule test --all'
        sh 'molecule test --all'
      }
    }

  } // close stages
}   // close pipeline
