node {
    stage 'checkout'
    checkout scm
    stage 'setup'
    rbenv()
    nvm()
    sh 'bundle install'
    sh 'bundle exec rake db:drop db:create'
    stage 'unit tests'
    return_code = sh returnStatus: true, script: 'bundle exec rspec --tag ~fail -r rspec_junit_formatter --format RspecJunitFormatter -o test.xml --format progress'
    if (return_code != 0) {
        currentBuild.result = 'FAILURE'
    }
    stage 'archive'
    junit allowEmptyResults: true, testResults: "test.xml"
    publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'coverage', reportFiles: 'index.html', reportName: 'SimpleCov report'])
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
