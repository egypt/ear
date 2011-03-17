require 'resolv'

	def name
		"ReverseDNS"
	end

	def description
		"Reverse DNS Lookup"
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
		[Domain]
	end

	def setup(object, options={})
		super(object, options)
		self
	end

	def run
		begin
			name = Resolv.new.getname(@object.ip).to_s

			if name
				@object.name = name 
				@object.add_fact("Resolved name: #{name}") 
			
		  		## find out if we already know about this domain
				existing_domain = Domain.find_by_name(@object.domain_string)
			
				if existing_domain
					if !@object.domains.exists?(existing_domain) ## already attached?
						@object.domains << existing_domain
						existing_domain.add_fact("Added from reverse lookup on #{@object.name}")
					end
				else	## we didn't know it, create it
					d = @object.domains.create(:name => @object.domain_string)
					d.add_fact("Created from reverse lookup on #{@object.name}")
				end
			end
		rescue
			
		end
		
		@object.save!

	end
