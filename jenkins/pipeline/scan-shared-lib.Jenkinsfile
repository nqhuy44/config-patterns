
pipeline {
    agent any
    tools {nodejs "NodeJS"}
    parameters {
        // string(name: 'AWS_REGION', defaultValue: 'ap-east-1', description: 'AWS region where ECR and EKS are located')
        // string(name: 'EKS_CLUSTER_NAME', defaultValue: 'livevpn-dev-ekscluster-hk-01', description: 'Name of the EKS cluster')
        // string(name: 'NAMESPACE', defaultValue: 'dev', description: 'Kubernetes namespace')
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Environment')
        string(name: 'SERVICE_NAME', defaultValue: 'jenkins-shared-libary', description: 'Service name')
        string(name: 'EMAIL_RECIPIENTS', defaultValue: '', description: 'Email recipients for notifications')
        string(name: 'TARGET_BRANCH', defaultValue: 'main', description: 'Target branch to merge PR')
    }
    environment {   
        // Load the credential into an environment variable
        JIRA_SITE       = credentials('JIRA_SITE')
        SONAR_HOST_URL  = credentials('SONAR_HOST_URL')
    }

    stages {
        stage('Checkout Shared Lib Repositories') {
            steps {
                script {
                    // Checkout Service Repo
                    dir('jenkins-shared-lib-test') {
                        checkout([$class: 'GitSCM',
                                  branches: [[name: 'develop']],
                                  userRemoteConfigs: [[credentialsId: 'CI_GITHUB_CREDENTIALS',
                                                      url: 'https://github.com/nqhuy44/jenkins-shared-lib-test.git']]])
                    }
                }
            }   
        }


        stage('Dependency-Check') {
            steps {
                script {
                    sh 'echo "Dependency-Check"'
                }
                
            }
        }
    }
}