require './lib/conwayrb/version.rb'

PROJECT_NAME = 'conwayrb'
VERSION = CONWAYRB_VERSION

task :package do
  sh "gem build #{PROJECT_NAME}.gemspec"
  mkdir './gems'
  mv "#{PROJECT_NAME}-#{VERSION}.gem", './gems/'
end

task :clean do
  rm_rf './gems'
end

task :test do
  sh 'spinach'
end
