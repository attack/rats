module Rats
  class Data
  
    attr_accessor :value
  
    def initialize(value=nil)
      self.value = value
    end
    
    def nil!; @value = nil; end
    
    #
    # READ & WRITE
    #
    
    def value=(value)
      return unless value
      @value = self.class.transform(value)
      raise ArgumentError unless self.valid?
    end
    alias v= value=
    alias v value
    
    # optional: override this in a sub-class
    #
    def self.transform(value); value; end
    
    #
    # DISPLAY
    #
    
    def to_s
      return nil unless @value
      self.value.to_s
    end

    # it is expected that a specfic data sub-class will re-define this
    #
    def self.padding_width; 1; end
    def self.padding_value; " "; end
    
    def to_p
      return nil unless @value
      self.value.to_s.rjust(self.class.padding_width,self.class.padding_value)
    end
  
    #
    # TRAVERSING
    #
    # - it is expected that a specfic data sub-class will define this
    #
    
    def up; traverse(:up); end
    def up!; traverse!(:up); end
    alias north up
    alias north! up!
    
    def right; traverse(:right); end
    def right!; traverse!(:right); end
    alias east right
    alias east! right!
    
    def down; traverse(:down); end
    def down!; traverse!(:down); end
    alias south down
    alias south! down!
    
    def left; traverse(:left); end
    def left!; traverse!(:left); end
    alias west left
    alias west! left!
    
    #
    # VALIDATION
    #
    # - it is expected that a specfic data sub-class will re-define this
    #
    
    def valid?
      true
    end
    
    private
    
    def traverse(direction); raise NotImplementedError; end
    def traverse!(direction); raise NotImplementedError; end
  
  end
end