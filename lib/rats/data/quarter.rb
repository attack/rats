module Rats
  class Quarter < Data
    
    VALID_QUARTERS = [:ne, :nw, :se, :sw, :n, :e, :s, :w]
    
    def self.padding_width; 2; end
    def self.padding_value; " "; end
    
    def self.transform(value)
      value.to_s.upcase if value
    end
    
    def fullname
      return "" unless self.value
      template = "the %s %s"
      case self.value.to_s.downcase.to_sym
      when :ne
        sprintf(template, 'Northeast', 'Quarter')
      when :se
        sprintf(template, 'Southeast', 'Quarter')
      when :nw
        sprintf(template, 'Northwest', 'Quarter')
      when :sw
        sprintf(template, 'Southwest', 'Quarter')
      when :n
        sprintf(template, 'North', 'Half')
      when :e
        sprintf(template, 'East', 'Half')
      when :s
        sprintf(template, 'South', 'Half')
      when :w
        sprintf(template, 'West', 'Half')
      else
        ''
      end
    end
    
    def self.half?(value)
      %w(north n south s east e west w).include?(value.to_s.downcase)
    end
    
    def self.transform(value)
      v = value.to_s.upcase.strip
      case v
      when 'NORTH'
        v = 'N'
      when 'SOUTH'
        v = 'S'
      when 'EAST'
        v = 'E'
      when 'WEST'
        v = 'W'
      end
      v
    end
    
    private
    
    def validate!
      return unless self.value
      VALID_QUARTERS.include?(self.value.to_s.downcase.to_sym)
    end
    
  end
end