node {
  checkout scm
  stage 'unit tests'
  env.PATH = "\$HOME/.rbenv/shims:\$HOME/.rbenv/bin:${env.PATH}"
  sh 'bundle install --without development'
  sh 'bundle exec rake test'
}
