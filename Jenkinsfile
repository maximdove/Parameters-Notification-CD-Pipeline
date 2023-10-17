pipeline {
    agent any
    parameters {
        choice(name: 'Environment', choices: ['dev', 'qa'], description: 'Select Environment')
        string(name: 'Version', defaultValue: 'latest', description: 'Enter the version number')
    }
    stages {
        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker image to the selected environment
                    sh "docker run -d -e ENV=${params.Environment} --name my-web-app-${params.Environment} -p 80:80 maximdove/my-web-app:${params.Version}"
                }
            }
        }
        stage('Health Check') {
            steps {
                script {
                    // Health check using curl
                    sh "sleep 10" // Give the container some time to start
                    sh "curl http://localhost/health"
                }
            }
        }
    }
    post {
        success {
            script {
                // Send email notification on successful deployment
                emailext subject: "Deployment Successful", body: "The deployment to ${params.Environment} was successful.", to: 'maximdove@gmail.com'
            }
        }
        failure {
            script {
                // Send email notification on failed deployment
                emailext subject: "Deployment Failed", body: "The deployment to ${params.Environment} failed.", to: 'maximdove@gmail.com'
            }
        }
    }
}
