require 'resolv'

	def name
		"reverse_lookup"
	end

	def description
		"Reverse DNS Lookup"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Device]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[Device]
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
			name = Resolv.new.getname(@object.ip_address).to_s

			if name
				@object.name = name 			
		  	
		  	## find out if we already know about this domain
				existing_domain = Domain.find_by_name(@object.domain_string)
			
				if existing_domain
					if !@object.domains.exists?(existing_domain) ## already attached?
            create_object Domain, { :name => name }
					end
				else	## we didn't know it, create it
					create_object Domain, {:name => name}
				end
			else
			  raise "Sorry, couldn't find a name."
			end
		rescue
		
		end
		
		@object.save!
		
    nil
	end
