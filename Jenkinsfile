def remote = [:]
remote.name = "vagrant"
remote.host = "172.28.128.4"
remote.allowAnyHosts = true

node {
    withCredentials([sshUserPrivateKey(credentialsId: 'vagrant-key', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'vagrant')]) {
        remote.user = vagrant
        remote.identityFile = identity
        stage("SSH Steps Rocks!") {
            sshCommand remote: remote, command: 'cd /home/vagrant; mkdir deployment', failOnError: false
            sshPut remote: remote, from: 'shutdown.sh' to: '/home/vagrant/deployment/'
            sshPut remote: remote, from: 'startup.sh' to: '/home/vagrant/deployment/'
            sshPut remote: remote, from: 'restart.sh' to: '/home/vagrant/deployment/'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 shutdown.sh; ./shutdown.sh'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; rm *.war', failOnError: false
            sshPut remote: remote, from: 'target/*.war' to: '/home/vagrant/deployment/'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 start.sh'
            sshCommand remote: remote, command: 'cd /home/vagrant/deployment; chmod 777 restart.sh; ./restart.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/start.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/restart.sh'
            sshRemove remote: remote, path: '/home/vagrant/deployment/shutdown.sh'
        }
    }
}