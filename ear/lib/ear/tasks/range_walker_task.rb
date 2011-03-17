require 'rex'

	def name
		"RangeWalker"
	end

	## Returns a string which describes what this task does
	def description
		"RangeWalker Task - Creates Hosts from a Network Range"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Network]
	end
	
	## Returns a--forhon arry of types that it will update
	def update_types
		[]
	end

	## Returns an array of types that the task will create
	def create_types
		[Host]
	end

	def setup(object, options={})
		super(object, options)
		self
	end

	## Default method, subclasses must override this
	def run
		super
	
		walker = Rex::Socket::RangeWalker.new(@object.range)
		walker.each { |ip|
			create_object Host, { 	:ip => ip,
						:network_id => @object.id }
		}
	end
