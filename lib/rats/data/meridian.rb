module Rats
  class Meridian < Data
    
    VALID_MERIDIANS = (4..6)
    
    def self.padding_width; 1; end
    def self.padding_value; " "; end
    
    def self.transform(value)
      return unless value
      value = value.to_s.upcase.reverse.chomp('W').reverse
      value.to_i > 0 ? value.to_i : nil
    end
    
    def valid?
      VALID_MERIDIANS.include?(self.value.to_i)
    end
    
    def to_s; "W" + self.value.to_s; end

  end
end