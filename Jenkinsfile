pipeline {
    agent {
        label 'buildServer'
    }
    stages {
        stage('Clone')
        {
            steps {
                echo 'Building...'
                sh '''
                # Проверяем, существует ли уже директория с репозиторием
                if [ -d "task17" ]; then
                    cd task17
                    git pull
                    cd ..
                else
                    git clone https://github.com/helistam/task17
                fi
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                cd task17/apache_files
                docker image prune -af
                docker build -t apachese:latest .
                cd ../nginx_files
                docker build -t task14.3:latest .
                '''
            }
        }
         stage('Push') {
            steps {
                withCredentials([string(credentialsId: 'AccessToken', variable: 'AccessToken')]) {
                    sh '''
                    docker tag apachese:latest ghcr.io/helistam/apache-task:latest
                    docker tag task14.3:latest ghcr.io/helistam/task14.3
                    
                    echo $AccessToken | docker login ghcr.io -u helistam --password-stdin
                    docker push ghcr.io/helistam/apache-task:latest
                    docker push ghcr.io/helistam/task14.3
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh '''
                docker pull ghcr.io/helistam/apache-task:latest
                docker pull ghcr.io/helistam/task14.3:latest
                wget https://raw.githubusercontent.com/helistam/task17/main/docker-compose.yml
                docker-compose -f docker-compose.yml up -d
                '''
            }
        }
    }
     post {
        always {
            echo 'Cleaning up...'
            deleteDir() // Удаление workspace
        }
    }
}
