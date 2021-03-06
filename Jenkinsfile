pipeline{
    agent any
    stages{
        stage('Prepare'){
            steps{
                script{
                    Date date = new Date()
                    env.NAME = date.format("yyyy-MM-dd")
                }
            }
            post{
                always{
                    script{
                        currentBuild.displayName = "node-app-${NAME}"
                    }
                }
            }
        }
        stage('Get repo'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'WipeWorkspace'],[$class: 'LocalBranch', localBranch: "**"]], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/Lockhart01/node-test.git']]])
                script{
                    env.VERSION = sh(script: 'cat node-app/package.json | grep version | cut -d":" -f2 | cut -d "\\"" -f2', , returnStdout: true).trim()
                }
                sh 'echo ${VERSION}'
                stash includes: '', name: 'app', allowEmpty: false
            }
        }
        stage('Build image'){
            agent{
                label 'docker'
            }
            steps{
                unstash 'app'
                withCredentials([usernamePassword(credentialsId: 'Dockerhub', passwordVariable: 'DPASSWORD', usernameVariable: 'DUSER')]){
                    sh 'chmod +x build.sh && ./build.sh'
                }

            }
        }
    }
}