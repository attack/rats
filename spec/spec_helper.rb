require 'rspec'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rats'
include Rats

RSpec.configure do |config|
  config.mock_with :mocha
end
