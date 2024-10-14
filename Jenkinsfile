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

        stage('Setup Build Environment') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            parallel {
                stage('Setup .NET SDK') {
                    steps {
                        sh '''
                            set -e
                            export DOTNET_ROOT=$HOME/.dotnet
                            export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
                            mkdir -p $DOTNET_ROOT
                            curl -L https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0 --install-dir $DOTNET_ROOT
                            dotnet --version || (echo ".NET SDK installation failed" && exit 1)
                        '''
                    }
                }
                stage('Setup Node.js and Angular CLI') {
                    steps {
                        sh '''
                            set -e
                            # Install Node.js directly to avoid NVM issues
                            curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
                            sudo apt-get install -y nodejs
                            node --version
                            npm --version
                            npm cache clean --force
                            npm install -g @angular/cli || (echo "Angular CLI installation failed" && exit 1)
                            ng version
                        '''
                    }
                }
            }
        }

        stage('Restore Dependencies') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            parallel {
                stage('Restore .NET Dependencies') {
                    steps {
                        sh '''
                            . "$HOME/.dotnet/dotnet-install.sh"
                            dotnet restore ServerSide/Api/Api.csproj
                            dotnet restore ServerSide/BL/BL.csproj
                            dotnet restore ServerSide/DA/DA.csproj
                        '''
                    }
                }
                stage('Install Node.js Dependencies') {
                    steps {
                        dir('ClientSide') {
                            sh '''
                                npm install
                            '''
                        }
                    }
                }
            }
        }

        stage('Build Applications') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            parallel {
                stage('Build .NET Backend') {
                    steps {
                        sh '''
                            . "$HOME/.dotnet/dotnet-install.sh"
                            dotnet build ServerSide/Api/Api.csproj --configuration Release
                            dotnet build ServerSide/BL/BL.csproj --configuration Release
                            dotnet build ServerSide/DA/DA.csproj --configuration Release
                        '''
                    }
                }
                stage('Build Angular Frontend') {
                    steps {
                        dir('ClientSide') {
                            sh '''
                                ng build --configuration production
                            '''
                        }
                    }
                }
            }
        }

        stage('Run Unit Tests') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            parallel {
                stage('Run .NET Tests') {
                    steps {
                        sh '''
                            . "$HOME/.dotnet/dotnet-install.sh"
                            dotnet test ServerSide/Api.Tests/Api.Tests.csproj
                        '''
                    }
                }
                stage('Run Angular Tests') {
                    steps {
                        dir('ClientSide') {
                            sh '''
                                ng test --watch=false --browsers=ChromeHeadless
                            '''
                        }
                    }
                }
            }
        }

        stage('Publish') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            steps {
                sh '''
                    . "$HOME/.dotnet/dotnet-install.sh"
                    dotnet publish ServerSide/Api/Api.csproj --configuration Release --output ./publish/backend
                '''
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

        stage('Deploy to Kubernetes') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            steps {
                sh "kubectl apply -f k8s-manifets/"
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
