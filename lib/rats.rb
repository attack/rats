$:.unshift(File.dirname(__FILE__))

require 'rats/base'
require 'rats/data'
require 'rats/boundaries'

module Rats
  
  def self.new(*args)
    Rats::Base.new(args)
  end
  
  # custom errors
  #
  #class OutOfSources < StandardError; end
  
end