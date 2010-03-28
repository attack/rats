module Rats
  class Section < Data
    
    def to_p(width=2)
      return nil unless @value
      self.value.to_s.rjust(width,"0")
    end
    
  end
end