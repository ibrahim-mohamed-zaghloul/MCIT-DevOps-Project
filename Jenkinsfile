pipeline {
    agent any
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
        stage('Install Node.js and npm') {
            steps {
                sh 'curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -'
                sh 'sudo apt-get install -y nodejs'
            }
        }
        stage('Install Angular CLI') {
            steps {
                sh 'sudo npm install -g @angular/cli@18.2.7' // Install Angular CLI with sudo
            }
        }
        stage('Install Server-Side Dependencies') {
            steps {
                dir('ServerSide') { // Navigate to the ServerSide directory
                    sh 'dotnet restore' // Restore .NET dependencies
                }
            }
        }
        stage('Install Client-Side Dependencies') {
            steps {
                dir('ClientSide') { // Navigate to the ClientSide directory
                    sh 'npm install' // Install Angular project dependencies
                }
            }
        }
        stage('Run Server-Side Tests') {
            steps {
                dir('ServerSide') { // Navigate to the ServerSide directory
                    sh 'dotnet test' // Run .NET tests
                }
            }
        }
        stage('Run Client-Side Tests') {
            steps {
                dir('ClientSide') { // Navigate to the ClientSide directory
                    sh 'ng test --watch=false --browsers=ChromeHeadless' // Run Angular tests
                }
            }
        }
        stage('Build Server-Side Docker Image') {
            steps {
                dir('ServerSide') { // Navigate to the ServerSide directory
                    sh 'docker build -t serverside .'
                }
            }
        }
        stage('Build Client-Side Docker Image') {
            steps {
                dir('ClientSide') { // Navigate to the ClientSide directory
                    sh 'docker build -t clientside .'
                }
            }
        }
        stage('Push Server-Side Docker Image') {
            steps {
                sh 'docker login -u ibrahim_zaghloul -p 9$29%3kZ2Q%DHedz' // Login to Docker Hub
                sh 'docker tag serverside ibrahimmohamedzaghloul/serverside:latest'
                sh 'docker push ibrahimmohamedzaghloul/serverside:latest'
            }
        }
        stage('Push Client-Side Docker Image') {
            steps {
                sh 'docker tag clientside ibrahimmohamedzaghloul/clientside:latest'
                sh 'docker push ibrahimmohamedzaghloul/clientside:latest'
            }
        }
    }
}
