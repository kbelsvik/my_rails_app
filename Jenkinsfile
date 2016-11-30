node {
    stage 'checkout'
    checkout scm
    stage 'setup'
    rbenv(version:'2.0.0-p648', gems: ['bundler'])
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

def rbenv(options=[version:'2.0.0-p648']) {
    version = options.version
    env.PATH = "\$HOME/.rbenv/shims:\$HOME/.rbenv/bin:${env.PATH}"
    sh """
    rbenv versions | grep ${version} || rbenv install ${version}
    rbenv local ${version}
    """
    if(options.gems) {
        for (i = 0; i < options.gems.size(); i++) {
            sh "gem list ${options.gems[i]} -i || gem install ${options.gems[i]}"
        }
    }
}
