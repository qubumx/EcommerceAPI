pipeline {
    agent any

    environment {
        IMAGE_NAME = 'qubumx/ecommerce-api'
        // Definimos el nombre del contenedor y la red para usarlos en el deploy
        CONTAINER_NAME = 'ecommerce-api'
        DOCKER_NETWORK = 'ecommerce-net'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

                stage('Build & Test') {
                    agent {
                        docker {
                            image 'mcr.microsoft.com/dotnet/sdk:9.0'
                        }
                    }
                    environment {
                        DOTNET_CLI_HOME = pwd()
                    }
                    steps {
                        sh 'dotnet test --configuration Release'
                    }
                }
        stage('Build Docker Image') {
            steps {
                script {
                    // Usamos el build number como tag
                    def taggedImage = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
                    docker.build(taggedImage, ".")
                }
            }
        }

        stage('Push Docker Image') {
            when { branch 'main' }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        def taggedImage = docker.image("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                        taggedImage.push()
                        // También actualizamos la etiqueta 'latest'
                        taggedImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            when { branch 'main' }
            steps {
                script {
                    // Inyectar el connection string de forma segura
                    withCredentials([string(credentialsId: 'postgres-conn-string', variable: 'DB_CONNECTION_STRING')]) {
                        
                        // Detener y eliminar el contenedor antiguo si existe
                        sh "docker stop ${CONTAINER_NAME} || true"
                        sh "docker rm ${CONTAINER_NAME} || true"

                        // Ejecutar el nuevo contenedor
                        def taggedImage = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
                        sh """
                            docker run -d --network ${DOCKER_NETWORK} --name ${CONTAINER_NAME} -p 8080:8585 \
                            -e "ASPNETCORE_ENVIRONMENT=Production" \
                            -e "ConnectionStrings:DefaultConnection=${DB_CONNECTION_STRING}" \
                            ${taggedImage}
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            // Limpieza opcional de la imagen en el agente Jenkins
            echo 'Pipeline finalizado.'
        }
    }
}
