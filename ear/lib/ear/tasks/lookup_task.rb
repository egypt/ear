	require 'resolv'

	def name
		"lookup"
	end

	## Returns a string which describes what this task does
	def description
		"Simple DNS Lookup"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Device, Domain]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[Device]
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

	  begin
			if @object.kind_of?(Device)
				if @object.name
					begin
						resolved_address = Resolv.new.getaddress(@object.name)
						@object.name = resolved_address
					rescue Exception => e
					  puts e
					end
				else
					raise "Error, object has no name to look up! Try a reverse lookup!"
				end

				## Attach Mail Servers?

				## Other Records?
				
			elsif @object.kind_of?(Domain)
				begin
					if @object.name
						begin
							resolved_address = Resolv.getaddress(@object.name)
							h = create_object Device, { :ip_address => resolved_address }
							h.domains << @object
						rescue Exception => e
						  puts e
						end
					else
						raise "Error, object has no name to look up! Try a reverse lookup!"
					end
				rescue 
					return
				end
				
			end
			
		rescue Exception => e
			puts e.to_s
		end
		
	
		
		@object.save!
    nil
	end
