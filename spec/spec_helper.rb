require 'rubygems'
require 'spec'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rats'
include Rats

Spec::Runner.configure do |config|
  
  config.mock_with :mocha
  
end
