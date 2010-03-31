module Rats
  class Section < Data
    
    VALID_SECTIONS = (1..36)
    
    UNBOUNDED_SECTION_MATRIX = {
      1 => [12, 6, nil, 2],
      2 => [11, 1, nil, 3],
      3 => [10, 2, nil, 4],
      4 => [9, 3, nil, 5],
      5 => [8, 4, nil, 6],
      6 => [7, 5, nil, 1],
      7 => [18, 8, 6, 12],
      8 => [17, 9, 5, 7],
      9 => [16, 10, 4, 8],
      10 => [15, 11, 3, 9],
      11 => [14, 12, 2, 10],
      12 => [13, 7, 1, 11],
      13 => [24, 18, 12, 14],
      14 => [23, 13, 11, 15],
      15 => [22, 14, 10, 16],
      16 => [21, 15, 9, 17],
      17 => [20, 16, 8, 18],
      18 => [19, 17, 7, 13],
      19 => [30, 20, 18, 24],
      20 => [29, 21, 17, 19],
      21 => [28, 22, 16, 20],
      22 => [27, 23, 15, 21],
      23 => [26, 24, 14, 22],
      24 => [25, 19, 13, 23],
      25 => [36, 30, 24, 26],
      26 => [35, 25, 23, 27],
      27 => [34, 26, 22, 28],
      28 => [33, 27, 21, 29],
      29 => [32, 28, 20, 30],
      30 => [31, 29, 19, 25],
      31 => [nil, 32, 30, 36],
      32 => [nil, 33, 29, 31],
      33 => [nil, 34, 28, 32],
      34 => [nil, 35, 27, 33],
      35 => [nil, 36, 26, 34],
      36 => [nil, 31, 25, 35],
    }
    
    BOUNDED_SECTION_MATRIX = {
      1 => [12, nil, nil, 2],
      2 => [11, 1, nil, 3],
      3 => [10, 2, nil, 4],
      4 => [9, 3, nil, 5],
      5 => [8, 4, nil, 6],
      6 => [7, 5, nil, nil],
      7 => [18, 8, 6, nil],
      8 => [17, 9, 5, 7],
      9 => [16, 10, 4, 8],
      10 => [15, 11, 3, 9],
      11 => [14, 12, 2, 10],
      12 => [13, nil, 1, 11],
      13 => [24, nil, 12, 14],
      14 => [23, 13, 11, 15],
      15 => [22, 14, 10, 16],
      16 => [21, 15, 9, 17],
      17 => [20, 16, 8, 18],
      18 => [19, 17, 7, nil],
      19 => [30, 20, 18, nil],
      20 => [29, 21, 17, 19],
      21 => [28, 22, 16, 20],
      22 => [27, 23, 15, 21],
      23 => [26, 24, 14, 22],
      24 => [25, nil, 13, 23],
      25 => [36, nil, 24, 26],
      26 => [35, 25, 23, 27],
      27 => [34, 26, 22, 28],
      28 => [33, 27, 21, 29],
      29 => [32, 28, 20, 30],
      30 => [31, 29, 19, nil],
      31 => [nil, 32, 30, nil],
      32 => [nil, 33, 29, 31],
      33 => [nil, 34, 28, 32],
      34 => [nil, 35, 27, 33],
      35 => [nil, 36, 26, 34],
      36 => [nil, nil, 25, 35],
    }
    
    def self.padding_width; 2; end
    def self.padding_value; "0"; end
    
    def self.transform(value)
      return unless value
      value.to_i > 0 ? value.to_i : nil
    end
    
    
    def valid?
      VALID_SECTIONS.include?(self.value.to_i)
    end
    
    private
    
    # as a section, we can only safely traverse within a township
    
    def traverse(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        BOUNDED_SECTION_MATRIX[self.v.to_i][0]
      when :right
        BOUNDED_SECTION_MATRIX[self.v.to_i][1]
      when :down
        BOUNDED_SECTION_MATRIX[self.v.to_i][2]
      when :left
        BOUNDED_SECTION_MATRIX[self.v.to_i][3]
      end
      raise Rats::OutOfTownship if new_value.nil?
      Rats::Section.new(new_value)
    end
    
    def traverse!(direction)
      raise ArgumentError unless self.v
      new_value = case direction.downcase.to_sym
      when :up
        UNBOUNDED_SECTION_MATRIX[self.v.to_i][0]
      when :right
        UNBOUNDED_SECTION_MATRIX[self.v.to_i][1]
      when :down
        UNBOUNDED_SECTION_MATRIX[self.v.to_i][2]
      when :left
        UNBOUNDED_SECTION_MATRIX[self.v.to_i][3]
      end
      raise Rats::IllegalTraverse if new_value.nil?
      Rats::Section.new(new_value)
    end
   
  end
end