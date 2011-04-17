require 'rex'

	def name
		"rangewalker"
	end

	## Returns a string which describes what this task does
	def description
		"RangeWalker Task - Creates Hosts from a Network Range"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[]
	end
	
	## Returns an array of types that it will update
	def update_types
		[]
	end

	## Returns an array of types that the task will create
	def create_types
		[Device]
	end

	def setup(object, options={})
		super(object, options)
		self
	end

	## Default method, subclasses must override this
	def run
		super
	
		walker = Rex::Socket::RangeWalker.new(@object)
		walker.each { |ip| Device.create(:ip_address => ip)}
	
	nil
	end

  def cleanup
    
  end
  