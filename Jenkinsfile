pipeline {
    agent any
    environment {
        DOTNET_PATH = "$HOME/.dotnet"
        PATH = "${env.PATH}:${DOTNET_PATH}" // Add .NET to PATH globally
        CHROME_BIN = '/usr/bin/google-chrome' // Set Chrome binary path
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Michael-Haleem/DockerizedCRUD3TierWebApp.git'
            }
        }
        stage('Install .NET SDK') {
            steps {
                sh 'wget https://dot.net/v1/dotnet-install.sh'
                sh 'chmod +x ./dotnet-install.sh'
                sh './dotnet-install.sh --version 8.0.402'
            }
        }
        stage('Verify .NET Installation') {
            steps {
                sh 'dotnet --version' // Check if dotnet command works
            }
        }
        stage('Install Server-Side Dependencies') {
            steps {
                dir('ServerSide') {
                    sh 'dotnet restore' // Restore .NET dependencies
                }
            }
        }
        stage('Install Client-Side Dependencies') {
            steps {
                dir('ClientSide') {
                    sh 'npm install' // Install Angular project dependencies
                }
            }
        }
        stage('Run Server-Side Tests') {
            steps {
                dir('ServerSide') {
                    sh 'dotnet test' // Run .NET tests
                }
            }
        }
        stage('Run Client-Side Tests') {
            steps {
                dir('ClientSide') {
                    sh 'ng test --watch=false --browsers=ChromeHeadless' // Run Angular tests
                }
            }
        }
        stage('Build Server-Side Docker Image') {
            steps {
                dir('ServerSide') {
                    sh 'docker build -t serverside .'
                }
            }
        }
        stage('Build Client-Side Docker Image') {
            steps {
                dir('ClientSide') {
                    sh 'docker build -t clientside .'
                }
            }
        }
        stage('Push Server-Side Docker Image') {
            steps {
            
                sh 'docker tag serverside michaelhaleem/serverside:latest'
                sh 'docker push michaelhaleem/serverside:latest'
            }
        }
        stage('Push Client-Side Docker Image') {
            steps {
                sh 'docker tag clientside michaelhaleem/clientside:latest'
                sh 'docker push michaelhaleem/clientside:latest'
            }
        }
    }
}
