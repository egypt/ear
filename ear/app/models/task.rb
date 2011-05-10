
class Task

  ## Rails compatibility
  def self.all
    TaskManager.tasks
  end
  
  def self.find(num)
    TaskManager.tasks[num]
  end

  ## End Rails compatibility

	def initialize
		#@object = nil
		#@options = {}
	end

	## just another task
	def name
		"Generic"
	end

	## Returns a string which describes what this task does
	def description
		"Doesn't do anything!"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[]
	end

	## Returns an array of types that the task will create
	def create_types
		[]
	end
	
	## Where the pre-run setup happens, 
	def setup(object, options={})	
	  #puts "Task Setup Called!"
	  #puts "Object class: #{object.class}"
		raise "Sorry dude, no tasks like that here...."	unless allowed_types.include?(object.class)
		@object = object
		@options = options
	end
	
	## magic happens here
	def run
	  #puts "Task Run Called!"
		@task_run = TaskRun.create( 	
		        :task_name => name, 
					 	:task_object_type => @object.class.to_s,
					 	:task_object_id => @object.id, 
					 	:task_options_hash => @options )
	end
	
	def cleanup
	  #puts "Task Cleanup Called!"
	end
	
	## Checks for validity, subclasses can override if they'd like
	def valid?
		return true
	end
	
	def to_s
		"#{name}: #{description}"
	end
	
	## Convenience method that makes it easy to create
	## objects from within a task. designed to simplify the 
	## task api. do not override.
	def create_object(type, params)
		## TODO - check for dupes here
		#puts "TODO - implement check for dupes!"
		## Call the create method for this type
		
		#puts "DEBUG: Creating: #{type}"
		#puts "DEBUG: Params: #{params}"
		
		x = type.send(:create!, params)
		
		#puts "DEBUG: #{x}"
		## Keep track of the information that created this object
		x.map_parent({ :parent => @object, :task_run_id => @task_run.id})
		return x 
	end
end

