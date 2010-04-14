module Rats
  class Data
  
    ERROR = "not allowed"
    attr_accessor :value, :raise_errors, :error
  
    def initialize(value=nil, raise_errors=false)
      self.value = value
      self.raise_errors = raise_errors
    end
    
    def nil!; @value = nil; end
    def raise_errors!; @raise_errors = true; end
    def raise_errors?; @raise_errors == true; end
    
    #
    # READ & WRITE
    #
    
    def value=(value)
      return unless value
      @value = self.class.transform(value)
      raise ArgumentError if self.raise_errors? && !self.valid?
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
    # VALIDATION
    #
    # - it is expected that a specfic data sub-class will re-define this
    #
    
    def valid?
      set_error! unless valid = validate!
      valid
    end


    private

    def set_error!
      self.error = ERROR
    end
    
    def validate!
      true
    end
  
  end
end