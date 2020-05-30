def remote = [:]
remote.name = "vagrant"
remote.host = "172.28.128.4"
remote.allowAnyHosts = true

node {
    withCredentials([sshUserPrivateKey(credentialsId: 'vagrant-key', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'vagrant')]) {
        remote.user = vagrant
        remote.identityFile = identity
        stage("Git Checkout"){
           git 'https://github.com/ankurpathak/jenkins-demo.git'
        }
        stage("Maven Build"){
            sh """
                mvn clean package
                mv target/jenkins-demo*.war target/jenkins-demo.war
            """
        }
        stage("SSH Steps Rocks!") {
            sshCommand remote: remote, command: 'cd /home/vagrant; mkdir deployment', failOnError: false
            sshPut remote: remote, from: 'shutdown.sh', into: '/home/vagrant/deployment/'
            sshPut remote: remote, from: 'startup.sh', into: '/home/vagrant/deployment/'
            sshPut remote: remote, from: 'restart.sh', into: '/home/vagrant/deployment/'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 shutdown.sh; ./shutdown.sh', failOnError: false
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; rm *.war', failOnError: false
            sshPut remote: remote, from: 'target/jenkins-demo.war', into: '/home/vagrant/deployment/'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 startup.sh'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 restart.sh; ./restart.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/startup.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/restart.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/shutdown.sh'
        }
    }
}