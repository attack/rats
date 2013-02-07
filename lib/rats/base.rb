module Rats
  class Base
    attr_accessor :errors

    def initialize(*args)
      return unless args.flatten!
      @quarter = Rats::Quarter.new
      @section = Rats::Section.new
      @township = Rats::Township.new
      @range = Rats::Range.new
      @meridian = Rats::Meridian.new
      @errors = {}
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

    def location(format = :default)
      case format
      when :short
        short_location
      when :padded
        padded_location
      when :long
        long_location
      else
        default_location
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
      default_location
    end

    def scope
      if self.meridian && self.range && self.township
        if self.section
          if self.quarter
            if Rats::Quarter.half?(self.quarter)
              :half
            else
              :quarter
            end
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
      # check each data field individually
      [:meridian, :range, :township, :section, :quarter].each do |data|
        valid = self.send(data.to_s.chars.first).valid?
        add_error(data, self.send(data.to_s.chars.first).error) unless valid
      end

      # check each field as it relates to others
      self.exists? unless self.errors.size > 0

      # are we valid?
      self.errors.size == 0
    end

    # test that a location actually exists
    #
    def exists?
      # make sure meridian exists
      unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian]
        add_error(:land, 'does not exist')
        return false
      end

      # make sure range exists
      unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range]
        add_error(:land, 'does not exist')
        return false
      end

      # make sure township exists
      unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:townships].include?(self.township)
        add_error(:land, 'does not exist')
        return false
      end

      # make sure section exists

      # it is possible all sections exists for all townships
      if TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range].has_key?(:sections)
        # NO, now see if this township has valid sections
        if TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:sections].has_key?(self.township)
          # YES, check further to see that this section is listed
          unless TOWNSHIPS_BY_RANGE_AND_MERIDIAN[self.meridian][self.range][:sections][self.township].include?(self.section)
            add_error(:land, 'does not exist')
            return false
          else
            return true
          end
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

    # can this location be broken down into quarter sections?
    #
    def is_divisible?
      [:half, :section, :township].include?(self.scope)
    end

    # returns individual quarter sections for a :half_section, :section or :township
    #
    def divide
      return unless self.is_divisible?
      case self.scope
      when :half
        self.divide_half
      when :section
        self.divide_section
      when :township
        self.divide_township
      end
    end

    def divide_half
      quarters = []
      locations = case self.quarter.to_s.downcase
      when 'n'
        ['NE','NW']
      when 's'
        ['SE','SW']
      when 'e'
        ['NE','SE']
      when 'w'
        ['NW','SW']
      when 'all'
        ['NE','NW','SE','SW']
      when 'nse'
        ['NE','NW','SE']
      when 'nsw'
        ['NE','NW','SW']
      when 'enw'
        ['NE','NW','SE']
      when 'esw'
        ['NE','SE','SW']
      when 'sne'
        ['NE','SE','SW']
      when 'snw'
        ['NW','SE','SW']
      when 'wse'
        ['NW','SE','SW']
      when 'wne'
        ['NE','NW','SW']
      when 'nws'
        ['NW','SE','SW']
      when 'nes'
        ['NE','SE','SW']
      when 'sen'
        ['NE','NW','SE']
      when 'swn'
        ['NE','NW','SW']
      when 'nwe'
        ['NE','NW','SE']
      when 'new'
        ['NE','NW','SW']
      when 'sew'
        ['NW','SE','SW']
      when 'swe'
        ['NE','SE','SW']
      end

      # create the required locations
      locations.each do |quarter|
        quarters << Rats.new(self.meridian, self.range, self.township, section || self.section, quarter)
      end

      quarters
    end

    def divide_section(section=nil)
      quarters = []
      ['NE', 'NW', 'SE', 'SW'].each do |quarter|
        quarters << Rats.new(self.meridian, self.range, self.township, section || self.section, quarter)
      end
      quarters
    end

    def divide_township
      quarters = []
      (1..36).each do |section|
        quarters += divide_section(section)
      end
      quarters
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
      location.to_s.match(/^\d{8}\D{0,2}/) ? :parcel_id : :description
    end

    def parse_description(description)
      # just skip the case of only a meridian ie: 'W4'
      unless description.to_s.match(/^w\d{1,3}$/i)
        quarter = description.to_s.scan(/^north|^south|^east|^west|^all|^nse|^nsw|^enw|^esw|^sne|^snw|^wse|^wne|^ne|^nw|^se|^sw|^n|^e|^s|^w/i)
        self.quarter = Rats::Quarter.transform(quarter[0]) if quarter && quarter.size > 0
      end

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
      result = parcel_id.to_s.scan(/^(\d{1})(\d{2})(\d{3})(\d{2})(\D{1,2})?/)
      return unless result && result.size > 0
      numbers = result.pop.compact
      self.meridian = numbers.shift.to_i if numbers.size > 0
      self.range = numbers.shift.to_i if numbers.size > 0
      self.township = numbers.shift.to_i if numbers.size > 0
      self.section = numbers.shift.to_i if numbers.size > 0
      self.quarter = numbers.shift.to_s.strip if numbers.size > 0
      true
    end

    def set_values(values)
      self.meridian = values.shift.to_i if values.size > 0
      self.range = values.shift.to_i if values.size > 0
      self.township = values.shift.to_i if values.size > 0
      self.section = values.shift.to_i if values.size > 0
      self.quarter = values.shift.to_s if values.size > 0
    end


    def default_location
      if self.quarter
        "#{@quarter.to_s} #{[@section.to_s,@township.to_s,@range.to_s].compact.join('-')} #{@meridian.to_s}".strip
      else
        "#{[@section.to_s,@township.to_s,@range.to_s].compact.join('-')} #{@meridian.to_s}".strip
      end
    end

    def short_location
      [@meridian.to_p,@range.to_p,@township.to_p,@section.to_p,@quarter.to_p].compact.join('').strip
    end

    def padded_location
      if self.quarter
        "#{@quarter.to_p} #{[@section.to_p,@township.to_p,@range.to_p].compact.join('-')} #{@meridian.to_s}".strip
      else
        "#{[@section.to_p,@township.to_p,@range.to_p].compact.join('-')} #{@meridian.to_s}".strip
      end
    end

    def long_location
      quarter_section = []
      quarter_section << self.q.fullname if (self.q && self.q.fullname.size > 0)
      quarter_section << self.s.fullname if (self.s && self.s.fullname.size > 0)
      parts = []
      parts << quarter_section.compact.join(' of ') if (quarter_section && quarter_section.size > 0)
      parts << self.t.fullname
      parts << self.r.fullname
      parts << self.m.fullname
      parts.compact.join(', ')
    end

    def add_error(index, the_error)
      @errors[index] = [] unless @errors.has_key?(index)
      @errors[index] << the_error
    end

  end
end
