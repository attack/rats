module Rats
  class Section < Data
    
    VALID_SECTIONS = (1..36)
    
    def self.padding_width; 2; end
    def self.padding_value; "0"; end
    
    def self.transform(value)
      return unless value
      value.to_i > 0 ? value.to_i : nil
    end
    
    def fullname
      @value && @value.to_i > 0 ? "Section #{@value}" : ''
    end
    
    private
    
    def validate!
      VALID_SECTIONS.include?(self.value.to_i)
    end
   
  end
end