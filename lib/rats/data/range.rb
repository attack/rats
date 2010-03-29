module Rats
  class Range < Data
    
    VALID_RANGES = (1..30)
    
    def self.padding_width; 2; end
    def self.padding_value; "0"; end
    
    # NOTE: this does not take into consideration that some ranges do not
    # exist for some meridians and township (y-axis) values ... but we
    # would need to know those values, and that is outside the scope
    # of the Range class.  The Base class will handle these cases.
    #
    def valid?
      VALID_RANGES.include?(self.value.to_i)
    end
    
  end
end