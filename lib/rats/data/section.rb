module Rats
  class Section < Data
    
    VALID_SECTIONS = (1..36)
    
    def self.padding_width; 2; end
    def self.padding_value; "0"; end
    
    def valid?
      VALID_SECTIONS.include?(self.value.to_i)
    end
    
  end
end