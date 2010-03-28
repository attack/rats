module Rats
  class Data
  
    attr_accessor :value
  
    def initialize(value=nil)
      self.value = value
    end
  
    def v=(value)
      self.value = value
    end
    
    def v
      self.value
    end
  
    def to_p(width=1)
      return nil unless @value
      self.value.to_s.rjust(width,"0")
    end
  
    def to_s
      return nil unless @value
      self.value.to_s
    end
  
  end
end