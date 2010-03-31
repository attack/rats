module Rats
  class Quarter < Data
    
    VALID_QUARTERS = [:ne, :nw, :se, :sw]
    
    # order: up, right, down, left
    UNBOUNDED_QUARTER_MATRIX = {
      :se => [:ne, :sw, :ne, :sw],
      :sw => [:nw, :se, :nw, :se],
      :nw => [:sw, :ne, :sw, :ne],
      :ne => [:se, :nw, :se, :nw]
    }
    BOUNDED_QUARTER_MATRIX = {
      :se => [:ne, nil, nil, :sw],
      :sw => [:nw, :se, nil, nil],
      :nw => [nil, :ne, :sw, nil],
      :ne => [nil, nil, :se, :nw]
    }
    
    def self.padding_width; 2; end
    def self.padding_value; " "; end
    
    def self.transform(value)
      value.to_s.upcase if value
    end
    
    def valid?
      VALID_QUARTERS.include?(self.value.to_s.downcase.to_sym)
    end

    private
    
    # as a quarter, we can only safely traverse within a section
    
    def traverse(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        BOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][0]
      when :right
        BOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][1]
      when :down
        BOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][2]
      when :left
        BOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][3]
      end
      raise Rats::OutOfSection if new_value.nil?
      Rats::Quarter.new(new_value)
    end
    
    def traverse!(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        UNBOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][0]
      when :right
        UNBOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][1]
      when :down
        UNBOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][2]
      when :left
        UNBOUNDED_QUARTER_MATRIX[self.v.to_s.downcase.to_sym][3]
      end
      Rats::Quarter.new(new_value)
    end
    
  end
end