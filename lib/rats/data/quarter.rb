module Rats
  class Quarter < Data
    
    VALID_QUARTERS = [:ne, :nw, :se, :sw]
    
    def self.padding_width; 2; end
    def self.padding_value; " "; end
    
    def valid?
      VALID_QUARTERS.include?(self.value.to_s.downcase.to_sym)
    end

  end
end