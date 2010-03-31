module Rats
  class Township < Data
    
    VALID_TOWNSHIPS = (1..126)
    
    def self.padding_width; 3; end
    def self.padding_value; "0"; end
    
    def self.transform(value)
      return unless value
      value.to_i > 0 ? value.to_i : nil
    end
    
    # NOTE: this does not take into consideration that some townships do not
    # exist for some meridians and ranges (x-axis) values ... but we
    # would need to know those values, and that is outside the scope
    # of the Township class.  The Base class will handle these cases.
    #
    def valid?
      VALID_TOWNSHIPS.include?(self.value.to_i)
    end
    
    def traverse(direction); raise IllegalTraverse; end
    alias taverse! traverse
    
  end
end