require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
 	 
 	subject(:cuboid){Cuboid.new(dimensions: [2,3,4], origin: [0,0,0])}

 	describe ".initialize" do 
 		it "raises an argument error" do 
			expect{Cuboid.new(dimensions: [])}.to raise_error(ArgumentError) 	
			expect{Cuboid.new(dimensions: [1,2,3,4,5])}.to raise_error(ArgumentError) 	
			expect{Cuboid.new(origin: [])}.to raise_error(ArgumentError) 	
			expect{Cuboid.new(origin: [1,2,3,4,5])}.to raise_error(ArgumentError) 	
		end
 	end
  
  describe ".move_to!" do
    it "changes the origin in the simple happy case" do
      expect(cuboid.move_to!(1,1,1)).to be true
    end

    it "changes the vertices" do 
      cuboid.move_to!(1,1,1)
      expect(cuboid.vertices).to eq([
      	[1, 1, 1], 
      	[4, 1, 1], 
      	[4, 5, 1], 
      	[4, 1, 3], 
      	[4, 5, 3], 
      	[1, 5, 3], 
      	[1, 1, 3], 
      	[1, 5, 1]
      ])
    end

    #TODO: do not allow person to move_to! if there is an intersecting cuboid in the box!
  end    
  
  describe ".intersects?" do
  	let(:not_intersecting_cuboid){ Cuboid.new(dimensions: [5,5,5], origin: [5,5,5])}
		let(:intersecting_cuboid){ Cuboid.new(dimensions: [5,5,5], origin: [0,0,0])}
  	
  	it "returns false if the other cuboid is inside the boundaries" do
  		expect(not_intersecting_cuboid.intersects?(cuboid)).to eq false
  	end

  	it "returns true if the other cuboid is outside the boundaries " do
	  		expect(intersecting_cuboid.intersects?(cuboid)).to eq true  	
  	end

  end

  describe ".vertices" do 
  	it "returns a collection of vertices" do
  		expect(cuboid.vertices).to eq([
  			[0, 0, 0], 
  			[3, 0, 0], 
  			[3, 4, 0], 
  			[3, 0, 2], 
  			[3, 4, 2], 
  			[0, 4, 2], 
  			[0, 0, 2], 
  			[0, 4, 0]
  		])
  	end
  end

end
