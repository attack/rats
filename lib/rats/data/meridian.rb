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
    
    def to_s; "W" + self.value.to_s; end
    
    def fullname
      template = "West of the %s Meridian"
      case @value.to_i
      when 4
        sprintf(template, 'Fourth')
      when 5
        sprintf(template, 'Fifth')
      when 6
        sprintf(template, 'Sixth')
      else
        ''
      end
    end
    
    private
        
    def validate!
      VALID_MERIDIANS.include?(self.value.to_i)
    end

  end
end