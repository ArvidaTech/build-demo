pipeline {
  environment { 
    registry = "arvidatech/demo-pipeline" 
    registryCredential = 'docker' 
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
    stage("Build: TU") {
      steps {
        sh 'mvn test'
      }
    }
	
    stage("Build: Compile Package") {
      steps {
        sh 'mvn package'
      }
    }
		
    stage("Build: docker build and tag img") {
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
    stage("Post-Build: Scan docker image") {
      steps {
      }
    }	  

  }
post {
  success {
    echo 'Run Deploy pipeline!'
    build job: 'deploy-demo', parameters: [string(name: 'img', value: registry + ":$BUILD_NUMBER" )]
        }
    }
}
