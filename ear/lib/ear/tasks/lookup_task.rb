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
		[Host, Domain]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[Host]
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

	begin

			if @object.kind_of?(Host)
			
				if @object.name
					begin
						resolved_address = Resolv.new.getaddress(@object.name)
						puts "Resolved ip: #{resolved_address}"
						@object.name = resolved_address

					rescue
						puts "No address found."
					end
				else
					puts "Error, object has no name to look up! Try a reverse lookup!"
				end

				## Attach Mail Servers?

				## Other Records?
				
			elsif @object.kind_of?(Domain)
				begin
					if @object.name
						begin
							resolved_address = Resolv.getaddress(@object.name)
							puts "Resolved ip: #{resolved_address}"
							h = create_object Host, { :ip => resolved_address }
							h.domains << @object
						rescue Exception => e
							puts e
						end

					else
						puts "Error, object has no name to look up! Try a reverse lookup!"
					end
				rescue 
					return
				end
			end
			
		rescue Exception => e
			puts e.to_s
		end
		
	
		
		@object.save!
	end
