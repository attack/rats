require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rats" do
  
  it "initializes the class" do
    land = Rats.new
    land.is_a?(Rats::Base).should be_true
  end
  
  describe "attributes" do
    
    before(:each) do
      @land = Rats.new
    end
    
    describe "writing and reading" do
      
      it "writes quarter" do
        @land.quarter = "NE"
        @land.quarter.should == "NE"
      end
      
      it "writes section" do
        @land.section = 1
        @land.section.should == 1
      end
      
      it "writes township" do
        @land.township = 1
        @land.township.should == 1
      end
      
      it "writes range" do
        @land.range = 1
        @land.range.should == 1
      end
      
      it "writes meridian" do
        @land.meridian = 4
        #@land.meridian.should == "W4"
        @land.meridian.should == 4
      end
      
    end
    
  end
  
  describe "parsing locations" do
    
    it "understands NE 1-2-3 W4" do
      land = Rats.new("NE 1-2-3 W4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands NE 1-1-1-4" do
      land = Rats.new("NE 1-2-3-4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands NE 1 2 3 4" do
      land = Rats.new("NE 1 2 3 4")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands 40300201NE" do
      land = Rats.new("40300201NE")
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    # NOT SURE THIS IS USEFUL
    # it "understands NE01002034" do
    #   land = Rats.new("NE01002034")
    #   land.quarter.should == "NE"
    #   land.section.should == 1
    #   land.township.should == 2
    #   land.range.should == 3
    #   land.meridian.should == "W4"
    # end
    
    it "understands 1-2-3 W4" do
      land = Rats.new("1-2-3 W4")
      land.quarter.should be_nil
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands 2-3 W4" do
      land = Rats.new("2-3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands 3 W4" do
      land = Rats.new("3 W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands W4" do
      land = Rats.new("W4")
      land.quarter.should be_nil
      land.section.should be_nil
      land.township.should be_nil
      land.range.should be_nil
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands individual values" do
      land = Rats.new("NE", 1, 2, 3, 4)
      land.quarter.should == "NE"
      land.section.should == 1
      land.township.should == 2
      land.range.should == 3
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    it "understands SE 1-119-24 W4" do
      land = Rats.new("SE 1-119-24 W4")
      land.quarter.should == "SE"
      land.section.should == 1
      land.township.should == 119
      land.range.should == 24
      #land.meridian.should == "W4"
      land.meridian.should == 4
    end
    
    describe "alternate method" do
    
      it "using location and a string" do
        land = Rats.new
        land.location = "NE 1-2-3 W4"
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        #land.meridian.should == "W4"
        land.meridian.should == 4
      end

      it "using location and individual values" do
        land = Rats.new
        land.location = ["NE", 1, 2, 3, 4]
        land.quarter.should == "NE"
        land.section.should == 1
        land.township.should == 2
        land.range.should == 3
        land.meridian.should == 4
        #land.meridian.to_s.should == "W4"
      end
      
    end
    
  end
  
  describe "validation (does it exist)" do
    
    # each individual field has already been tested to know what is a valid field
    # here, I am testing the location as a whole, as a location can be valid
    # in respect to its individual components, but not as a whole
    
    it "knows a valid and existing location" do
      land = Rats.new("SE 1-2-3 W4")
      land.location.should == "SE 1-2-3 W4"
      land.exists?.should be_true
    end
    
    it "knows an non-existing section (in a valid township)" do
      land = Rats.new("SE 2-119-24 W4")
      land.exists?.should be_false
      
      # but it neightbour does
      land = Rats.new("SE 1-119-24 W4")
      land.exists?.should be_true
    end
    
    it "knows an non-existing township (in a valid range)" do
      land = Rats.new("SE 1-19-30 W4")
      land.exists?.should be_false
    end
    
    it "knows an non-existing range (in a valid township)" do
      land = Rats.new("SE 1-20-30 W4")
      land.exists?.should be_false
    end
    
  end
  
  describe "boundaries" do
                    
    it "knows when a township is North of Alberta" do
      lambda { Rats.new("SE 1-127-1 W4") }.should raise_error(ArgumentError)
    end
    
    it "knows when a township is East of Alberta" do
      lambda { Rats.new("SE 1-1-1 W3") }.should raise_error(ArgumentError)
    end
    
    it "knows when a township is West of Alberta" do
      lambda { Rats.new("SE 1-1-1 W7") }.should raise_error(ArgumentError)
    end
    
  end
  
  describe "taversing" do
    
    describe "from quarter to quarter" do
    
      describe "within a township" do
    
        describe "within a section" do
      
          it "knows what is up (north)" do
            land = Rats.new("SE 1-2-3 W4")
            land.up.location.should == "NE 1-2-3 W4"
          end
      
          it "knows what is down (south)" do
            land = Rats.new("NE 1-2-3 W4")
            land.down.location.should == "SE 1-2-3 W4"
          end
      
          it "knows what is left (west)" do
            land = Rats.new("SE 1-2-3 W4")
            land.left.location.should == "SW 1-2-3 W4"
          end
      
          it "knows what is right (east)" do
            land = Rats.new("SW 1-2-3 W4")
            land.right.location.should == "SE 1-2-3 W4"
          end
      
        end
    
        describe "outside a section" do
        
          it "knows what is up (north)" do
            land = Rats.new("NE 1-2-3 W4")
            land.up.location.should == "SE 12-2-3 W4"
          end

          it "knows what is down (south)" do
            land = Rats.new("SE 12-2-3 W4")
            land.down.location.should == "NE 1-2-3 W4"
          end

          it "knows what is left (west)" do
            land = Rats.new("SW 1-2-3 W4")
            land.left.location.should == "SE 2-2-3 W4"
          end

          it "knows what is right (east)" do
            land = Rats.new("NE 2-2-3 W4")
            land.right.location.should == "NW 1-2-3 W4"
          end
        
        end
        
      end
      
      describe "outside a township (which implies outside a section)" do

        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township

        it "knows it can't go up (north)" do
          land = Rats.new("NE 36-2-3 W4")
          lambda { land.up }.should raise_error(IllegalTraverse)
        end

        it "knows it can't go down (south)" do
          land = Rats.new("SE 1-2-3 W4")
          lambda { land.down }.should raise_error(IllegalTraverse)
        end

        it "knows what is left (west)" do
          land = Rats.new("SW 6-2-3 W4")
          land.left.location.should == "SE 1-2-4 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("NE 1-2-3 W4")
          land.right.location.should == "NW 6-2-2 W4"
        end

      end
      
      describe "outside a meridian (which implies outside a section and township)" do

        # NOTE: you cannot leave a meridian by going North or South

        it "knows what is left (west)" do
          land = Rats.new("SW 6-2-30 W4")
          land.left.location.should == "SE 1-2-1 W5"
        end

        it "knows what is right (east)" do
          land = Rats.new("NE 1-2-1 W5")
          land.right.location.should == "NW 6-2-30 W4"
        end

      end
      
      describe "with complicated gaps in valid quarter sections" do
        
        # this is the ultimate test(s).  Can we traverse to the next quarter
        # when the normal rules do not apply for what is next?
        
        def skip(q,s,t,m)
          skips = (q + s*2 + t*6*2 + m*30*6*2) || 0
          skips -= 1 unless skips == 0
          answers = ([false]*skips + [true]).to_a
        
          Rats::Base.any_instance.stubs(:valid?).returns(*answers)
        end
        
        it "should skip sections going left (west)" do 
          skip(1,0,0,0)
          
          land = Rats.new("NE 1-1-2 W4")
          new_land = land.left
          new_land.location.should == "NW 1-1-2 W4"
        end
        
        it "should skip sections going left (west)" do 
          skip(0,1,0,0)
          
          land = Rats.new("NW 1-1-2 W4")
          new_land = land.left
          new_land.location.should == "NW 2-1-2 W4"
        end
        
        it "should skip sections going left (west)" do 
          skip(0,0,1,0)
          
          land = Rats.new("NW 1-1-2 W4")
          new_land = land.left
          new_land.location.should == "NW 1-1-3 W4"
        end
        
        it "should skip sections going left (west)" do 
          skip(0,0,0,1)
          
          land = Rats.new("NW 1-1-2 W4")
          new_land = land.left
          new_land.location.should == "NW 1-1-2 W5"
        end
        
      end
      
    end
    
    describe "from section to section" do
    
      describe "within a township" do
      
        it "knows what is up (north)" do
          land = Rats.new("1-2-3 W4")
          land.up.location.should == "12-2-3 W4"
        end
      
        it "knows what is down (south)" do
          land = Rats.new("7-2-3 W4")
          land.down.location.should == "6-2-3 W4"
        end
      
        it "knows what is left (west)" do
          land = Rats.new("12-2-3 W4")
          land.left.location.should == "11-2-3 W4"
        end
      
        it "knows what is right (east)" do
          land = Rats.new("6-2-3 W4")
          land.right.location.should == "5-2-3 W4"
        end
      
      end
    
      describe "outside a township" do
        
        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township
      
        it "knows it can't go up (north)" do
          land = Rats.new("35-2-3 W4")
          lambda { land.up }.should raise_error(IllegalTraverse)
        end

        it "knows it can't go down (south)" do
          land = Rats.new("1-2-3 W4")
          lambda { land.down }.should raise_error(IllegalTraverse)
        end

        it "knows what is left (west)" do
          land = Rats.new("6-2-3 W4")
          land.left.location.should == "1-2-4 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("1-2-3 W4")
          land.right.location.should == "6-2-2 W4"
        end
        
      end
      
    end
    
    describe "from township to township" do
      
      describe "within a meridian" do
              
        it "knows it can't go up (north)" do
          land = Rats.new("2-3 W4")
          lambda { land.up }.should raise_error(IllegalTraverse)
        end
        
        it "knows it can't go down (south)" do
          land = Rats.new("2-3 W4")
          lambda { land.down }.should raise_error(IllegalTraverse)
        end
      
        it "knows what is left (west)" do
          land = Rats.new("2-3 W4")
          land.left.location.should == "2-4 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("2-3 W4")
          land.right.location.should == "2-2 W4"
        end

      end
      
    end
    
    describe "from quarter to section" do
      
      describe "within a township" do

        it "knows what is up (north)" do
          land = Rats.new("SE 1-2-3 W4")
          land.up(:section).location.should == "12-2-3 W4"
        end

        it "knows what is down (south)" do
          land = Rats.new("NE 7-2-3 W4")
          land.down(:section).location.should == "6-2-3 W4"
        end

        it "knows what is left (west)" do
          land = Rats.new("NE 12-2-3 W4")
          land.left(:section).location.should == "11-2-3 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("NW 6-2-3 W4")
          land.right(:section).location.should == "5-2-3 W4"
        end

      end

      describe "outside a township" do
      
        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township
      
        it "knows it can't go up (north)" do
          land = Rats.new("SE 35-2-3 W4")
          lambda { land.up(:section) }.should raise_error(IllegalTraverse)
        end
      
        it "knows it can't go down (south)" do
          land = Rats.new("NE 1-2-3 W4")
          lambda { land.down(:section) }.should raise_error(IllegalTraverse)
        end
      
        it "knows what is left (west)" do
          land = Rats.new("NE 6-2-3 W4")
          land.left(:section).location.should == "1-2-4 W4"
        end
      
        it "knows what is right (east)" do
          land = Rats.new("NW 1-2-3 W4")
          land.right(:section).location.should == "6-2-2 W4"
        end
      
      end
      
    end
    
    describe "from quarter to township" do
      
      describe "within a meridian" do
              
        it "knows it can't go up (north)" do
          land = Rats.new("NE 1-2-3 W4")
          lambda { land.up(:township) }.should raise_error(IllegalTraverse)
        end
        
        it "knows it can't go down (south)" do
          land = Rats.new("NE 1-2-3 W4")
          lambda { land.down(:township) }.should raise_error(IllegalTraverse)
        end
      
        it "knows what is left (west)" do
          land = Rats.new("NE 1-2-3 W4")
          land.left(:township).location.should == "2-4 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("NE 1-2-3 W4")
          land.right(:township).location.should == "2-2 W4"
        end

      end
      
    end
    
    describe "from section to township" do
      
      describe "within a meridian" do
              
        it "knows it can't go up (north)" do
          land = Rats.new("1-2-3 W4")
          lambda { land.up(:township) }.should raise_error(IllegalTraverse)
        end
        
        it "knows it can't go down (south)" do
          land = Rats.new("1-2-3 W4")
          lambda { land.down(:township) }.should raise_error(IllegalTraverse)
        end
      
        it "knows what is left (west)" do
          land = Rats.new("1-2-3 W4")
          land.left(:township).location.should == "2-4 W4"
        end

        it "knows what is right (east)" do
          land = Rats.new("1-2-3 W4")
          land.right(:township).location.should == "2-2 W4"
        end

      end
      
    end
    
    describe "chaining" do
      
      it "allows chaining of traversing" do
        land = Rats.new("NE 1-2-3 W4")
        land.up.down.left.right.location.should == "NE 1-2-3 W4"
      end
      
    end
    
  end
  
  describe "formatting" do
    
    describe ":long" do
    
      it "returns NE 1-2-3 W4" do
        land = Rats.new("NE 1-2-3 W4")
        land.location.should == "NE 1-2-3 W4"
      end
    
      it "returns 1-2-3 W4" do
        land = Rats.new("1-2-3 W4")
        land.location.should == "1-2-3 W4"
      end
    
      it "returns 2-3 W4" do
        land = Rats.new("2-3 W4")
        land.location.should == "2-3 W4"
      end
      
    end
    
    describe ":short" do
    
      it "returns NE01002034" do
        land = Rats.new("NE 1-2-3 W4")
        land.location(:short).should == "NE01002034"
      end
      
      it "returns 01001014" do
        land = Rats.new("1-2-3 W4")
        land.location(:short).should == "01002034"
      end

      it "returns 001014" do
        land = Rats.new("2-3 W4")
        land.location(:short).should == "002034"
      end

    end
    
  end
  
  describe "scope" do
    
    it "knows quarter" do
      land = Rats.new("NE 1-2-3 W4")
      land.scope.should == :quarter
    end
    
    it "knows section" do
      land = Rats.new("1-2-3 W4")
      land.scope.should == :section
    end
    
    it "knows township" do
      land = Rats.new("2-3 W4")
      land.scope.should == :township
    end
    
    it "anything else is unknown" do
      land = Rats.new("3 W4")
      land.scope.should == :unknown
    end
    
  end
  
  describe "methods" do
    
    describe "validity" do
      
      it "knows when it is valid" do
        land = Rats.new("NE 1-2-3 W4")
        land.valid?.should be_true
      end
      
      it "knows when it isn't valid"do
        land = Rats.new("3 W4")
        land.valid?.should be_false
      end
      
    end
    
    it "responds_to :to_s" do
      land = Rats.new("NE 1-2-3 W4")
      land.to_s.should == land.location
    end
    
    it "responds_to :to_a" do
      land = Rats.new("NE 1-2-3 W4")
      land.to_a.should == ['NE', 1, 2, 3, 4]
      
      land = Rats.new("1-2-3 W4")
      land.to_a.should == [1, 2, 3, 4]
    end
                    
  end
  
end
