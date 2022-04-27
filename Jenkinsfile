pipeline {
  environment { 
    registry = "arvidatech/demo-pipeline" 
    registryCredential = 'ArvidaTech' 
    dockerImage = '' 
  }
  agent any
  stages { 
	  
    stage("Pre-Build: Clone git repo") {
      steps {
        git branch: 'main', url: 'https://github.com/ArvidaTech/build-demo.git'
      }
    }
/*    stage('Pre-Build: Clean stage'){
      steps{
        sh 'mvn clean'
      }
    }
*/        
    stage("Build: Maven Package") {
      steps {
        sh 'mvn package'
      }
    }
	
	stage("Build: TU") {
      steps {
        sh 'mvn test'
      }
    }
	
    stage("Post-Build: docker img") {
      steps {
	  	script { 
          dockerImage = docker.build registry + ":$BUILD_NUMBER" 
		}
      }
    }
	
    stage("Post-Build: push docker image") {
      steps {
	    script { 
		  docker.withRegistry('', registryCredential) {
			dockerImage.push 'latest'
			dockerImage.push()
			}
		}	
      }
    }
	  
    stage("Invoke Deploy") {
      steps {
        build job: 'deploy-demo/main', parameters: [string(name: 'dockerImage', value:dockerImage),string(name: 'deploy_To', value:$HOST)], wait: false
      }
    }

  }
}
