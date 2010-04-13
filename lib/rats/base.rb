module Rats
  class Base
    
    def initialize(*args)
      return unless args.flatten!
      @quarter = Rats::Quarter.new
      @section = Rats::Section.new
      @township = Rats::Township.new
      @range = Rats::Range.new
      @meridian = Rats::Meridian.new
      if args.size == 1
        parse_string(args.pop)
      else
        set_values(args)
      end
    end
    
    def q; @quarter; end
    def s; @section; end
    def t; @township; end
    def r; @range; end
    def m; @meridian; end
    
    def q=(v); @quarter = v; end
    def s=(v); @section = v; end
    def t=(v); @township = v; end
    def r=(v); @range = v; end
    def m=(v); @meridian = v ; end

    def quarter; @quarter.v; end
    def section; @section.v; end
    def township; @township.v; end
    def range; @range.v; end
    def meridian; @meridian.v; end

    def quarter=(v); @quarter.v = v; end
    def section=(v); @section.v = v; end
    def township=(v); @township.v = v; end
    def range=(v); @range.v = v; end
    def meridian=(v); @meridian.v = v; end

    def location(format = :long)
      case format
      when :short
        short_location
      when :long
        long_location
      else
        long_location
      end
    end

    def location=(value)
      return unless value
      if value.is_a?(Array)
        set_values(value)
      else  
        parse_string(value)
      end
    end
    
    def to_s
      long_location
    end

    def scope
      if self.meridian && self.range && self.township
        if self.section
          if self.quarter
            :quarter
          else
            :section
          end
        else
          :township
        end
      else
        :unknown
      end
    end

    def valid?
      self.meridian && self.range && self.township && self.exists?
    end
    
    # test that a location actually exists
    #
    def exists?
      # make sure meridian exists
      return false unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian]
      
      # make sure range exists
      return false unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range]
      
      # make sure township exists
      return false unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:townships].include?(self.township)
      
      # make sure section exists
      
      # it is possible all sections exists for all townships
      if TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range].has_key?(:sections)
        # NO, now see if this township has valid sections
        if TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:sections].has_key?(self.township)
          # YES, check further to see that this section is listed          
          return TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:sections][self.township].include?(self.section)
        else
          # the township isn't listed, therefore it has all sections
          return true
        end
      else
        # looks like we exist
        return true
      end
    end
    
    def to_a
      [self.quarter, self.section, self.township, self.range, self.meridian].compact
    end
       
    private

    def parse_string(location)
      return unless location.respond_to?('to_s')

      case location_type?(location)
      when :description
        parse_description(location)
      when :parcel_id
        parse_parcel_id(location)
      end
    end

    def location_type?(location)
      location.to_s.match(/^\d{8}\D{2}/) ? :parcel_id : :description
    end

    def parse_description(description)
      quarter = description.to_s.scan(/^\D{2}/)
      self.quarter = quarter[0].upcase if quarter && quarter.size > 0

      numbers = description.to_s.scan(/\d{1,3}/)
      if numbers
        self.meridian = numbers.pop.to_i if numbers.size > 0
        self.range = numbers.pop.to_i if numbers.size > 0
        self.township = numbers.pop.to_i if numbers.size > 0
        self.section = numbers.pop.to_i if numbers.size > 0
      end
      true
    end

    def parse_parcel_id(parcel_id)
      result = parcel_id.to_s.scan(/^(\d{1})(\d{2})(\d{3})(\d{2})(\D{2})/)
      return unless result && result.size > 0
      numbers = result.pop
      self.meridian = numbers.shift.to_i if numbers.size > 0
      self.range = numbers.shift.to_i if numbers.size > 0
      self.township = numbers.shift.to_i if numbers.size > 0
      self.section = numbers.shift.to_i if numbers.size > 0
      self.quarter = numbers.shift.to_s if numbers.size > 0
      true
    end

    def set_values(values)
      self.meridian = values.shift.to_i if values.size > 0
      self.range = values.shift.to_i if values.size > 0
      self.township = values.shift.to_i if values.size > 0
      self.section = values.shift.to_i if values.size > 0
      self.quarter = values.shift.to_s if values.size > 0
    end
    

    def long_location
      if self.quarter
        "#{@quarter.to_s} #{[@section.to_s,@township.to_s,@range.to_s].compact.join('-')} #{@meridian.to_s}".strip
      else
        "#{[@section.to_s,@township.to_s,@range.to_s].compact.join('-')} #{@meridian.to_s}".strip
      end
    end

    def short_location
      [@quarter.to_p,@section.to_p,@township.to_p,@range.to_p,@meridian.to_p].compact.join('').strip
    end
    
  end
end
