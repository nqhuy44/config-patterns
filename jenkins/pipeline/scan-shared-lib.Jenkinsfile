    pipeline {
        agent any
        // parameters {
        //     // string(name: 'SERVICE_NAME', defaultValue: 'config-manager', description: 'Service name')
        //     // string(name: 'SERVICE_REPOSITORY', defaultValue: 'config-manager', description: 'ECR repository for config-manager')
        //     // string(name: 'SERVICE_MIGRATION_REPOSITORY', defaultValue: 'config-manager-migration', description: 'ECR repository for migration')
        //     // string(name: 'SERVICE_API_DEPLOYMENT_NAME', defaultValue: 'config-manager', description: 'Config Manager Deployment Name')
        //     // string(name: 'EMAIL_RECIPIENTS', defaultValue: '', description: 'Email recipients for notifications')
        //     // string(name: 'TARGET_BRANCH', defaultValue: '', description: 'Target branch to merge PR')
        // }
        // environment {   
        //     // Load the credential into an environment variable
        //     // REPO_K8S_ASSETS = credentials('REPO_K8S_ASSETS')
        //     // JIRA_SITE       = credentials('JIRA_SITE')
        //     // SONAR_HOST_URL  = credentials('SONAR_HOST_URL')
        // }

        stages {
            stage('Checkout Shared Lib Repositories') {
                steps {
                    script {
                        // Checkout Service Repo
                        dir('jenkins-shared-lib-test') {
                            // checkout([$class: 'GitSCM',
                            //         branches: [[name: "${env.CHANGE_BRANCH}"]],
                            //         userRemoteConfigs: [[credentialsId: 'CI_GITHUB_CREDENTIALS',
                            //                             url: 'https://github.com/nqhuy44/jenkins-shared-lib-test.git']]])
                            sh "echo ${env.CHANGE_BRANCH}"
                        }
                    }
                }
            }
            stage('Lint') {
                steps {
                    // Run linting tools
                    sh 'echo "your-linting-command"'
                }
            }
        }
    }