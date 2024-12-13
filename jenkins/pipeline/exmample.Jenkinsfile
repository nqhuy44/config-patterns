@Library('shared-lib@v1.0.0') _
pipeline {
    agent any
    stages {
        stage('Stage 1') {
            steps {
                script {
                    simple()
                }
            }
        }
        stage('Stage 2') {
            steps {
                script {
                    simple()
                    simple2('Hello, World!')
                }
            }
        }
    }
}
