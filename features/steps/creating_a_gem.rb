require_relative "../../lib/conwayrb/version.rb"

class Spinach::Features::CreatingAGem < Spinach::FeatureSteps
  include RSpec::Matchers
  step 'I run \'rake package\'' do
    @exit_code = system('rake package 1>/dev/null 2>&1')
  end

  step 'it\'s exit code should be zero (succesfull)' do
       expect(@exit_code).to be true
  end

  step 'there should exist a .gem file with current version number' do
      expect(File.exist?("./gems/conwayrb-#{CONWAYRB_VERSION}.gem")).to be true
  end

  after do
      system('rake clean')
  end
end
