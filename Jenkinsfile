pipeline {
    agent any

    environment {
        DOTNET_CLI_TELEMETRY_OPTOUT = '1'
        DOTNET_NOLOGO = '1'
        CONFIGURATION = 'Release'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Restore') {
            steps {
                bat 'dotnet restore Ecommerce.sln'
            }
        }

        stage('Build') {
            steps {
                bat 'dotnet build Ecommerce.sln --no-restore -c %CONFIGURATION%'
            }
        }

        stage('Test') {
            steps {
                bat 'dotnet test Ecommerce.sln --no-build -c %CONFIGURATION%'
            }
        }

        stage('Publish') {
            when {
                branch 'main'
            }
            steps {
                bat 'dotnet publish Ecommerce.sln -c %CONFIGURATION% -o publish'
            }
        }
    }

    post {
        success {
            echo '✅ CI ejecutado correctamente'
        }
        failure {
            echo '❌ Falló el pipeline'
        }
        always {
            archiveArtifacts artifacts: 'publish/**', onlyIfSuccessful: true
        }
    }
}
