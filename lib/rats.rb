require 'rats/version'
require 'rats/base'
require 'rats/data'
require 'rats/boundaries'

module Rats
  def self.new(*args)
    Rats::Base.new(args)
  end

  class OutOfBounds < StandardError; end
  #class OutOfSection < OutOfBounds; end
  #class OutOfTownship < OutOfBounds; end
  #class OutOfMeridian < OutOfBounds; end
  #class OutOfAlberta < OutOfBounds; end
end
