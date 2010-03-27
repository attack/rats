module Rats
  
  attr_accessor :quarter, :section, :township, :range, :meridian
  
  class LegalLandDescription
    
    def initialize(*args)
      return unless args
      if args.size == 1
        parse_string(args.pop)
      else
        set_values(args)
      end
    end
    
    def meridian
      'W' + @meridian.to_s
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
      self.quarter = values.shift.to_s if values.size > 0
      self.section = values.shift.to_i if values.size > 0
      self.township = values.shift.to_i if values.size > 0
      self.range = values.shift.to_i if values.size > 0
      self.meridian = values.shift.to_i if values.size > 0
    end
    
  end
  
end