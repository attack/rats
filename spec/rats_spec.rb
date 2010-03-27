require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Rats" do
  
  it "initializes the class"
  
  describe "parsing locations" do
    
    it "understands NE 1-1-1 W4"
    
    it "understands NE 1-1-1-4"
    
    it "understands NE 1 1 1 4"
    
    it "understands 40100101NE"
    
    it "understands NE01001014"
    
    it "understands 1-1-1 W4"
    
    it "understands 1-1 W4"
    
    it "doesn't like 1 W4"
    
    it "doesn't like W4"
    
  end
  
  describe "boundaries" do
    
    it "knows a valid township (regardless of range)"
    
    it "knows a valid range based on township"
    
    it "knows a valid merdian"
    
    it "knows when a township (at a valid range,township,meridian) doesn't exist"
    
    it "knows when a township is North of Alberta"
    
    it "knows when a township is East of Alberta"
    
    it "knows when a township is West of Alberta"
    
  end
  
  describe "taversing" do
    
    describe "from quarter to quarter" do
    
      describe "within a township" do
    
        describe "within a section" do
      
          it "knows what is up (north)"
      
          it "knows what is down (south)"
      
          it "knows what is left (west)"
      
          it "knows what is right (east)"
      
        end
    
        describe "outside a section" do
        
          it "knows what is up (north)"

          it "knows what is down (south)"

          it "knows what is left (west)"

          it "knows what is right (east)"
        
        end
        
      end
      
      describe "outside a township (which inplies outside a section)" do

        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township

        it "knows it can't go up (north)"

        it "knows it can't go down (south)"

        it "knows what is left (west)"

        it "knows what is right (east)"

      end
      
    end
    
    describe "from section to section" do
    
      describe "within a township" do
      
        it "knows what is up (north)"
      
        it "knows what is down (south)"
      
        it "knows what is left (west)"
      
        it "knows what is right (east)"
      
      end
    
      describe "outside a township" do
        
        # townships do not line up North to South, so you can't know
        # what township/section/quarter is above another when you
        # leave a township
      
        it "knows it can't go up (north)"

        it "knows it can't go down (south)"

        it "knows what is left (west)"

        it "knows what is right (east)"
        
      end
      
    end
    
    describe "from township to township" do
      
      describe "within a meridian" do
      
        it "goes East"
        
        it "goes West"
        
        it "doesn't go North"
        
        it "doesn't go South"
      
      end
      
    end
    
    describe "from quarter to section" do
      
      it "TODO knows this"
      
    end
    
    describe "from quarter to township" do
      
      it "TODO knows this"
      
    end
    
    describe "from sectino to township" do
      
      it "TODO knows this"
      
    end
    
  end
  
  describe "formatting" do
    
    describe ":long" do
    
      it "returns NE 1-1-1 W4"
    
      it "returns 1-1-1 W4"
    
      it "returns 1-1 W4"
      
    end
    
    describe ":short" do
    
      it "returns NE01001014"
      
      it "returns 01001014"

      it "returns 001014"

    end
    
  end
  
  describe "scope" do
    
    it "knows quarter"
    
    it "knows section"
    
    it "knows township"
    
  end
  
  describe "attributes" do
    
    it "returns quarter"
    
    it "returns section"
    
    it "returns township"
    
    it "returns range"
    
    it "returns meridian"
    
  end
  
  describe "methods" do
    
    it "copies the class"
    
  end
  
end
