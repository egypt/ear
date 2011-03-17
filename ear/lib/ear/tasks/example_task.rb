	def name
		"Example"
	end

	## Returns a string which describes what this task does
	def description
		"This task creates & associates a host for every object it is given."
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Host, Domain, Network, Organization, User, Location, Service]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[]
	end

	## Returns an array of types that the task will create
	def create_types
		[Host]
	end

	def setup(object, options={})
		super(object, options)
	  puts "Example Task Setup Called"
		puts "Task Object: #{@object}"	
		puts "Options: #{@options}"	
		self
	end

	## Default method, subclasses must override this
	def run
	  	super
    
		puts "Example Task Run Called"
		puts "Object: #{@object}"
		puts "Task Run: #{@task_run.inspect}"
	
		ip = "#{rand(100)}.#{rand(100)}.#{rand(100)}.#{rand(100)}"
		x = create_object Host, { :ip => ip }
		
	end
	
	def cleanup
		super
		puts "Example Task Cleanup Called"
	end
