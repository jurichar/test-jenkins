def code

node {
  stage('Checkout') {
    checkout scm
  }

  stage('Load') {
    code = load 'hello.groovy'
  }

  stage('Execute') {
    code.example2()
  }
}