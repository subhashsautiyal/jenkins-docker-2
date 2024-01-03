pipeline {
    agent any 
    
    stages {
        stage("Clone Code") {
            agent {
                label 'React-Server' // Replace 'your_remote_node_label' with the label of your remote node
            }
            steps {
                echo "Cloning the code"
                git url: "https://github.com/subhashsautiyal/jenkins-docker-2.git", branch: "main"
            }
        }
        stage("Build") {
            agent any // Resetting the agent to execute this stage on any available node
            steps {
                echo "Building the image"
                sh "docker build -t my-react-app ."
            }
        }
        stage("Push to Docker Hub") {
            agent any // Resetting the agent to execute this stage on any available node
            steps {
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId:"dockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                    sh "docker tag my-react-app ${env.dockerHubUser}/my-react-app:latest"
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker push ${env.dockerHubUser}/my-react-app:latest"
                }
            }
        }
        stage("Deploy") {
            agent {
                label 'React-Server' // Replace 'your_remote_node_label' with the label of your remote node
            }
            steps {
                echo "Deploying the container"
                sh "docker-compose down && docker-compose up -d"
            }
        }
    }
}
