pipeline {
    agent any

    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
        // Hardcoded DockerHub credentials
        DOCKERHUB_USERNAME = "ahmedalmahdi"
        DOCKERHUB_PASSWORD = "1234qweasd"
        DOCKER_IMAGE_FRONT = "ahmedalmahdi/clientside"
        DOCKER_IMAGE_BACK = "ahmedalmahdi/serverside"
        
        // Hardcoded GitHub token
        GITHUB_REPO = "https://github.com/ahmed-el-mahdy/MCIT-DevOps-Project.git"
    }

    stages {
        stage('Check for Changes') {
            steps {
                script {
                    // Check if the repository already exists
                    def repoExists = fileExists('MCIT-DevOps-Project')
                    if (repoExists) {
                        dir('MCIT-DevOps-Project') {
                            // Fetch the latest changes
                            sh "git fetch origin"
                            // Check if there are any changes
                            def changes = sh(script: "git diff origin/main", returnStdout: true).trim()
                            if (changes) {
                                echo "Changes detected. Proceeding with build."
                                env.BUILD_NEEDED = 'true'
                                // Pull the latest changes
                                sh "git pull origin main"
                            } else {
                                echo "No changes detected. Skipping build."
                                env.BUILD_NEEDED = 'false'
                            }
                        }
                    } else {
                        echo "Repository doesn't exist locally. Cloning it."
                        sh "git clone https://github.com/ahmed-el-mahdy/MCIT-DevOps-Project.git"
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
                            wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                            sudo dpkg -i packages-microsoft-prod.deb
                            sudo apt-get update
                            sudo apt-get install -y dotnet-sdk-8.0
                            dotnet --version
                        '''
                    }
                }
                stage('Setup Node.js and Angular CLI') {
                    steps {
                        sh '''
                            curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
                            sudo apt-get install -y nodejs
                            node --version
                            npm --version
                            sudo npm install -g @angular/cli
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
                        sh 'dotnet restore ServerSide/Api/Api.csproj'
                        sh 'dotnet restore ServerSide/BL/BL.csproj'
                        sh 'dotnet restore ServerSide/DA/DA.csproj'
                    }
                }
                stage('Install Node.js Dependencies') {
                    steps {
                        dir('ClientSide') {
                            sh 'npm install'
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
                        sh 'dotnet build ServerSide/Api/Api.csproj --configuration Release'
                        sh 'dotnet build ServerSide/BL/BL.csproj --configuration Release'
                        sh 'dotnet build ServerSide/DA/DA.csproj --configuration Release'
                    }
                }
                stage('Build Angular Frontend') {
                    steps {
                        dir('ClientSide') {
                            sh 'ng build --configuration production'
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
                        sh 'dotnet test ServerSide/Api.Tests/Api.Tests.csproj'
                    }
                }
                stage('Run Angular Tests') {
                    steps {
                        dir('ClientSide') {
                            sh 'ng test --watch=false --browsers=ChromeHeadless'
                        }
                    }
                }
            }
        }

        stage('Publish') {
            when { environment name: 'BUILD_NEEDED', value: 'true' }
            steps {
                sh 'dotnet publish ServerSide/Api/Api.csproj --configuration Release --output ./publish/backend'
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
                script {
                    // Deploying the Docker images using Kubernetes manifests
                    sh "kubectl apply -f k8s-manifets/"
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