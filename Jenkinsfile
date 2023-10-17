pipeline {
    agent any
    parameters {
        choice(
            name: 'Environment',
            choices: ['dev', 'qa'],
            description: 'Select Environment'
        )
        string(
            name: 'Version',
            defaultValue: '1.0',
            description: 'Enter the version number'
        )
    }
    environment {
        DOCKER = credentials('docker-hub-credentials')
    }
    stages {
        stage('Build and Push') {
            steps {
                script {
                    // This block automatically logs in to Docker Hub, handles the push, and then logs out
                    withDockerRegistry([ credentialsId: 'docker-hub-credentials', url: '' ]) {
                        def image = docker.build("maximdove/my-web-app:${params.Version}")
                        image.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Remove any existing container with the same name
                    sh "docker rm -f my-web-app-${params.Environment} || true"
                    // Deploy the Docker image to the selected environment
                    sh "docker run -d -e ENV=${params.Environment} --name my-web-app-${params.Environment} -p 9090:80 maximdove/my-web-app:${params.Version}"
                }
            }
        }
        stage('Health Check') {
            steps {
                script {
                    sh "sleep 10" // Give the container some time to start
                    try {
                        sh "curl http://localhost:9090/health"
                    } catch (Exception e) {
                        error "Health check failed: ${e.message}"
                    }
                }
            }
        }
    }
    post {
        success {
            script {
                emailext(
                    subject: "Deployment Successful",
                    body: "The deployment to ${params.Environment} was successful.",
                    to: 'maximdove@gmail.com',
                    from: 'maximfeb@gmail.com'
                )
            }
        }
        failure {
            script {
                emailext(
                    subject: "Deployment Failed",
                    body: "The deployment to ${params.Environment} failed.",
                    to: 'maximdove@gmail.com',
                    from: 'maximfeb@gmail.com'
                )
            }
        }
    }
}
