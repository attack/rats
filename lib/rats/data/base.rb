module Rats
  class Data
  
    attr_accessor :value
  
    def initialize(value=nil)
      self.value = value
    end
    
    #
    # READ & WRITE
    #
    
    def value=(value)
      return unless value
      @value = value
      raise ArgumentError unless self.valid?
    end
    alias v= value=
    alias v value
    
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
    
    def left; raise NotImplementedError; end
    alias west left

    def right; raise NotImplementedError; end
    alias east right
    
    def up; raise NotImplementedError; end
    alias north up
    
    def down; raise NotImplementedError; end
    alias south down
    
    #
    # VALIDATION
    #
    # - it is expected that a specfic data sub-class will re-define this
    #
    
    def valid?
      true
    end
  
  end
end