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

    def meridian
      'W' + @meridian.to_s
    end

    def meridian_raw
      @meridian.to_i
    end

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
      self.meridian && self.range && self.township
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

      numbers = description.to_s.scan(/\d{1,2}/)
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
      #self.quarter = values.shift
      self.quarter = values.shift.to_s if values.size > 0
      self.section = values.shift.to_i if values.size > 0
      self.township = values.shift.to_i if values.size > 0
      self.range = values.shift.to_i if values.size > 0
      self.meridian = values.shift.to_i if values.size > 0
    end

    def long_location
      if self.quarter
        "#{self.quarter} #{[self.section,self.township,self.range].compact.join('-')} #{self.meridian}".strip
      else
        "#{[self.section,self.township,self.range].compact.join('-')} #{self.meridian}".strip
      end
    end

    def short_location
      [@quarter.to_p,@section.to_p,@township.to_p,@range.to_p,@meridian.to_p].compact.join('').strip
    end
    
  end
end
