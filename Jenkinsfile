node {
  stage 'setup
  checkout scm
  env.PATH = "\$HOME/.rbenv/shims:\$HOME/.rbenv/bin:${env.PATH}"
  which ruby
  which gem
  gem install bundler
  sh 'bundle install --without development'
  stage 'unit tests'
  sh 'bundle exec rake test'
}
