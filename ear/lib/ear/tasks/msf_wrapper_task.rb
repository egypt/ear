## todo, require msf libraries here. 
	def name
		"msf"
	end

	
	## Returns a string which describes what this task does
	def description
		"Msf Wrapper Task"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Host]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[Host]
	end

	## Returns an array of types that the task will create
	def create_types
		[]
	end

	def setup(object, options={})
		super(object, options)
		self
	end

	## Default method, subclasses must override this
	def run
		super
		## todo, run msf stuff here
		
		## Set up xmlrpc?
		
		## Run module & Capture results
		
		## Modify the object?
		
		@object.save!
	end

