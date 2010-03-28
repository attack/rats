module Rats
  class Meridian < Data
    
      def to_p(width=1)
        return nil unless @value
        self.value.to_s.rjust(width," ")
      end

  end
end