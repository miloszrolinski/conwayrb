require './lib/conwayrb/version.rb'

PROJECT_NAME = 'conwayrb'
VERSION = CONWAYRB_VERSION

task :package do
  sh "gem build #{PROJECT_NAME}.gemspec"
  mv "#{PROJECT_NAME}-#{VERSION}.gem", './gems'
end

task :clean do
  rm_rf './gems/*'
end
