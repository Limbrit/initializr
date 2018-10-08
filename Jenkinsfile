node {
    try{
        notify('Started')
        stage('checkout') {
            checkout scm
        } 
            stage('Clean') {
            sh 'mvn clean'
            }
            stage('Test') {
            sh 'mvn test'
            }
            stage('Package') {
            sh 'mvn package'
            }
			stage('Build Docker Image'){
				sh 'sudo docker build -t limbrit/initializr:0.0.1 .'
			}
			stage('Push Docker Image'){
			withCredentials([string(credentialsId: 'docker-pwd', variable: 'Dockerpwd')]) {
				sh "sudo docker login -u limbrit -p ${Dockerpwd}"
				}
   				sh 'sudo docker push limbrit/initializr:0.0.1'
			}
			stage('Running Docker on Local'){
				sh 'sudo docker run -p 8085:8085 -d limbrit/initializr:0.0.1'
			}
            archiveArtifacts 'target/*.jar'
        
        notify('Success')
    } catch (err) {
        notify("Error ${err}")
        currentBuild.result = 'FAILURE'
    }   
}
def notify(status){
    emailext (
      to: "ladaikalam@dxc.com",
      subject: "${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """<p>${status}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
    )
}
