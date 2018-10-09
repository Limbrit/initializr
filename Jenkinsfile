node {
    try{
        notify('Started')
        stage('checkout') {
            checkout scm
        } 
            stage('Clean') {
            sh 'sudo mvn clean'
            }
	    stage('Compile') {
            sh 'sudo mvn compile'
            }
            stage('Test') {
            sh 'sudo mvn test'
            }
            stage('Package') {
            sh 'sudo mvn package'
            }
			
        
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
