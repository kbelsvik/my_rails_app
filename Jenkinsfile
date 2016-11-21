node {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kbelsvik/my_rails_app']]])
    rbenv()
    nvm()
    sh 'bundle install'
    sh 'bundle exec rake db:drop db:create'
    sh 'bundle exec rspec --tag ~fail'
}

def nvm(options=[version:'node']) {
    version = options.version
    sh """
    export NVM_DIR="\$HOME/.nvm"
    [ -s "\$NVM_DIR/nvm.sh" ] && . "\$NVM_DIR/nvm.sh" # This loads nvm
    nvm version ${version} || nvm install ${version}
    nvm use ${version}
    echo \$NVM_BIN > node_bin.txt
    """
    def node_bin=readFile('node_bin.txt').trim()
    env.PATH = "${node_bin}:${env.PATH}"
}

def rbenv(options=[version:'2.0.0-p648']) {
    version = options.version
    env.PATH = "\$HOME/.rbenv/shims:\$HOME/.rbenv/bin:${env.PATH}"
    sh """
    rbenv versions | grep ${version} || rbenv install ${version}
    rbenv local ${version}
    """
    if(options.gems) {
        options.gems.each {
            sh "gem list ${it} -i || gem install ${it}"
        }
    }
}
