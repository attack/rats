module Rats
  class Quarter < Data
    
    VALID_QUARTERS = [:ne, :nw, :se, :sw]
    
    def self.padding_width; 2; end
    def self.padding_value; " "; end
    
    def self.transform(value)
      value.to_s.upcase if value
    end
    
    def fullname
      return "" unless self.value
      template = "the %s Quarter"
      case self.value.to_s.downcase.to_sym
      when :ne
        sprintf(template, 'Northeast')
      when :se
        sprintf(template, 'Southeast')
      when :nw
        sprintf(template, 'Northwest')
      when :sw
        sprintf(template, 'Southwest')
      else
        ''
      end
    end
    
    private
    
    def validate!
      return unless self.value
      VALID_QUARTERS.include?(self.value.to_s.downcase.to_sym)
    end
    
  end
end