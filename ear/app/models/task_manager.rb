require 'singleton'
require 'find'

class TaskManager

	include Singleton

	cattr_accessor :tasks
	cattr_accessor :tasks_dir
	
	def setup(path)
		@@tasks_dir = path
		@@task_files = []
		@@tasks = []
		#@running_tasks = []
	
	  load_tasks(@@tasks_dir)
	end
	
	def reload_tasks(dir=@@tasks_dir)
	  @@task_files = []
	  load_tasks(dir)
	end
	
	def load_tasks(dir=@@tasks_dir)
	  Dir.entries(dir).each do |entry| 
			if !(entry =~ /^\./) ## check for obvious directories
				if File.file? dir + "/" + entry ## make sure it's a file
					@@task_files.push dir + "/" + entry 
				end
			end
		end
		
		@@task_files.each do |task_file|
			task_data=[]
			
			File.open(task_file, "r").each { |line|	task_data << line }
			
 		  t = Task.new
			t.instance_eval(task_data.join("\n"))
			@@tasks << t
		end
	end
	
	def get_tasks_for(object)
		tasks_for_type = []

		@@tasks.each do |task|
			if task.allowed_types.include?(object.class)
				tasks_for_type << task
			end
		end
		
		tasks_for_type
	end
	
	def get_task_names
		module_names = []
		@@tasks.each do |task|
			module_names << task.name
		end
		module_names
	end

	def run_task(name, object, options={})
		## TODO - multithread
				
		#puts "Task manager running task: #{name}"
		#puts "Object: #{object}"
		#puts "Options: #{options}"
		
		## TODO - catch invalid tasks here!
		
		@@tasks.each do |task|
			if task.name.downcase == name.downcase
				task.setup(object, options)
				task.run
				task.cleanup
			end
		end
		
		return object
	end
	
end
