def remote = [:]
remote.name = "vagrant"
remote.host = "172.28.128.4"
remote.allowAnyHosts = true

node {
withCredentials([sshUserPrivateKey(credentialsId: 'vagrant-key', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'vagrant')]) {
        remote.user = vagrant
        remote.identityFile = identity
        stage("SSH Steps Rocks!") {
            sshCommand remote: remote, command: 'ls -ltr'
        }
    }
}