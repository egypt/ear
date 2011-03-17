class Application
	attr_accessor :task_manager
	attr_accessor :object_manager
	attr_accessor :root
	
	
	def initialize
		## EAR specific configuration
		@root = Rails.root

		## Set up task manager
		@task_manager = TaskManager.instance
		@task_manager.setup("#{@root}/lib/ear/tasks")
		
		## Set up the object manager
		@object_manager = ObjectManager.instance
	end

	def objects
		@object_manager.objects
	end
	
	def tasks
		@task_manager.tasks
	end
	
	def run_task(name, object, options={})
	
		puts "EAR running task #{name}"
		puts "Object: #{object}"
		puts "Options: #{options}"
	
		@task_manager.run_task(name, object, options)
	end

	def find_host(ip)
		Host.find_by_ip(ip)
	end

	def find_organization(name)
		Organization.find_by_name(name)
	end

	def find_network(range)
		Network.find_by_range(range)
	end		

	def find_domain(name)
		Domain.find_by_domain(name)
	end

	def find_email(name)
		User.find_by_email(email)
	end

	def find_service(name)
		Service.find_by_name(name)
	end

	def hosts
		Host.all
	end
	
	def organizations
		Organization.all
	end
	
	def networks
		Network.all
	end
	
	def domains
		Domain.all
	end
	
	def users
		User.all
	end
	
	def locations
		Location.all
	end
	
	def services
		Service.all
	end

end
