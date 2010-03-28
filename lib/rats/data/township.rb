module Rats
  class Township < Data
    
    def to_p(width=3)
      return nil unless @value
      self.value.to_s.rjust(width,"0")
    end
    
  end
end