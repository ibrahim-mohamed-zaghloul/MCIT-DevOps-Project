pipeline {
    agent any

    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
        DOCKERHUB_USERNAME = "ahmedalmahdi"
        DOCKERHUB_PASSWORD = "1234qweasd"
        DOCKER_IMAGE_FRONT = "ahmedalmahdi/clientside"
        DOCKER_IMAGE_BACK = "ahmedalmahdi/serverside"
        GITHUB_REPO = "https://github.com/ahmed-el-mahdy/MCIT-DevOps-Project.git"
        DOTNET_ROOT = "$HOME/.dotnet"
        PATH = "$PATH:$HOME/.dotnet:$HOME/.dotnet/tools:$HOME/.nvm/versions/node/v20.x.x/bin:$HOME/.npm-global/bin"
        NVM_DIR = "$HOME/.nvm"
    }

    stages {
        stage('Check for Changes') {
            steps {
                script {
                    def repoExists = fileExists('MCIT-DevOps-Project')
                    if (repoExists) {
                        dir('MCIT-DevOps-Project') {
                            sh "git fetch origin"
                            def changes = sh(script: "git diff origin/main", returnStdout: true).trim()
                            if (changes) {
                                echo "Changes detected. Proceeding with build."
                                env.BUILD_NEEDED = 'true'
                                sh "git pull origin main"
                            } else {
                                echo "No changes detected. Skipping build."
                                env.BUILD_NEEDED = 'false'
                            }
                        }
                    } else {
                        echo "Repository doesn't exist locally. Cloning it."
                        sh "git clone ${GITHUB_REPO}"
                        env.BUILD_NEEDED = 'true'
                    }
                }
            }
        }

        stage('Build Docker Images') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            parallel {
                stage('Build Backend Docker Image') {
                    steps {
                        dir('ServerSide') {
                            sh "docker build -t ${DOCKER_IMAGE_BACK} -f Dockerfile ."
                        }
                    }
                }
                stage('Build Frontend Docker Image') {
                    steps {
                        dir('ClientSide') {
                            sh "docker build -t ${DOCKER_IMAGE_FRONT} -f Dockerfile ."
                        }
                    }
                }
            }
        }

        stage('Push Docker Images') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    sh "docker push ${DOCKER_IMAGE_BACK}"
                    sh "docker push ${DOCKER_IMAGE_FRONT}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            sh 'docker logout'
        }
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
