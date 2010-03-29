module Rats
  class Meridian < Data
    
    VALID_MERIDIANS = (4..6)
    
    def self.padding_width; 1; end
    def self.padding_value; " "; end
    
    def valid?
      VALID_MERIDIANS.include?(self.value.to_i)
    end

  end
end