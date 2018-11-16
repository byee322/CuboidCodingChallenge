class Cuboid

  def initialize(options={})
  	raise ArgumentError if !options.has_key?(:dimensions) || !options.has_key?(:origin)
  	raise ArgumentError if options[:dimensions].length > 3 || options[:origin].length > 3
		#assuming always integer values
		@l = options[:dimensions][0]
		@w = options[:dimensions][1]
		@h = options[:dimensions][2]

		move_to!(options[:origin][0], options[:origin][1], options[:origin][2])
  end

  def move_to!(x, y, z)
  	@origin_x, @origin_y, @origin_z = x, y, z
    @max_x = @origin_x + @w
    @max_y = @origin_y + @h
    @max_z = @origin_z + @l
    true
  end
  
  def vertices
  	[
      [@origin_x, @origin_y, @origin_z],
      [@max_x, @origin_y, @origin_z ],
      [@max_x, @max_y, @origin_z],
      [@max_x, @origin_y, @max_z],
      [@max_x, @max_y, @max_z],
      [@origin_x, @max_y, @max_z],
      [@origin_x, @origin_y, @max_z],
      [@origin_x, @max_y, @origin_z]
    ]
  end
  
   #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other_cuboid)

    other_cuboid.vertices.each do |vertex|
	  	#if any are inside the cube they are intersecting
      return true if interior?(vertex)
    end

    #if you share one vertex
    if (other_cuboid.vertices & self.vertices).length > 0
    	#check to see if the other cuboid is inside your boundaries
			self.vertices.each do |vertex|
				return true if interior?(vertex)
			end 
    end
 	
 		return false
  end

  #END public methods that should be your starting point  

  private

  #returns true if the point is inside the boundaries
  def interior?(coords)
    x, y, z = coords
    x > @origin_x && 
    x < @max_x &&
    y > @origin_y && 
    y < @max_y &&
    z > @origin_z && 
    z < @max_z
  end
end