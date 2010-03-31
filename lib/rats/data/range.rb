module Rats
  class Range < Data
    
    VALID_RANGES = (1..30)
    
    def self.padding_width; 2; end
    def self.padding_value; "0"; end
    
    def self.transform(value)
      return unless value
      value.to_i > 0 ? value.to_i : nil
    end
    
    # NOTE: this does not take into consideration that some ranges do not
    # exist for some meridians and township (y-axis) values ... but we
    # would need to know those values, and that is outside the scope
    # of the Range class.  The Base class will handle these cases.
    #
    def valid?
      VALID_RANGES.include?(self.value.to_i)
    end
    
    private
    
    # as a range, we can only safely traverse within a meridian
    
    def traverse(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        raise IllegalTraverse
      when :right
        self.v.to_i > VALID_RANGES.min ? self.v.to_i - 1 : nil
      when :down
        raise IllegalTraverse
      when :left
        self.v.to_i < VALID_RANGES.max ? self.v.to_i + 1 : nil
      end
      raise Rats::OutOfMeridian if new_value.nil?
      Rats::Range.new(new_value)
    end
    
    def traverse!(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        raise IllegalTraverse
      when :right
        self.v.to_i > VALID_RANGES.min ? self.v.to_i - 1 : VALID_RANGES.max
      when :down
        raise IllegalTraverse
      when :left
        self.v.to_i < VALID_RANGES.max ? self.v.to_i + 1 : VALID_RANGES.min
      end
      Rats::Range.new(new_value)
    end
    
  end
end