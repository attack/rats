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
    
    private
    
    # as a meridian, we can only safely traverse within alberta
    
    def traverse(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        raise IllegalTraverse
      when :right
        self.v.to_i > VALID_MERIDIANS.min ? self.v.to_i - 1 : nil
      when :down
        raise IllegalTraverse
      when :left
        self.v.to_i < VALID_MERIDIANS.max ? self.v.to_i + 1 : nil
      end
      raise Rats::OutOfAlberta if new_value.nil?
      Rats::Meridian.new(new_value)
    end
    alias traverse! traverse

  end
end