node {
  stage 'setup'
  checkout scm
  env.PATH = "\$HOME/.rbenv/shims:\$HOME/.rbenv/bin:${env.PATH}"
  sh 'rbenv install 2.0.0-p648'
  sh 'rbenv local 2.0.0-p648'
  sh 'which ruby'
  sh 'which gem'
  sh 'gem install bundler'
  sh 'bundle install --without development'
  stage 'unit tests'
  sh 'bundle exec rake test'
}
