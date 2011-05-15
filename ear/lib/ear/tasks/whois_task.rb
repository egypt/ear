require 'whois'
require 'rex'

	def name
		"whois"
	end

	## Returns a string which describes what this task does
	def description
		"Performs a whois & updates the database"
	end
	
	## Returns an array of valid types for this task
	def allowed_types
		[Domain,Device]
	end
	
	def update_types
		[Domain,Device]
	end

	## Creates these types
	def create_types
		[Domain,Device,Organization]
	end

	def setup(object, options={})
		super(object, options)
	  @client = Whois::Client.new(:timeout => 10)
	  self
	end

	## Default method, subclasses must override this
	def run
		begin
			
			if @object.kind_of?(Device)
				answer = @client.query(@object.ip_address)
			elsif @object.kind_of?(User)
			elsif @object.kind_of?(Organization)
			  
			  answer = @client.query(@object.name)
			  answer.contacts.each do |contact|
          l = create_object Location, :address => contact.address,
                                      :state => contact.state,
                                      :city => contact.city,
                                      :zip => contact.zip,
                                      :country => contact.country

			    create_object User, :full_name => contact.name,
			                        :email => contact.email,
			                        :phone => contact.phone,
			                        :fax => contact.fax,
			                        :location_id => l.id
			  end
			  
		  elsif @object.kind_of?(Domain)
				begin
					answer = @client.query(@object.domain)
				rescue 
					return
				end

				@object.referral_whois = answer.referral_whois
				@object.referral_url = answer.referral_url
				@object.status = answer.status
				@object.created_on = answer.created_on
				@object.updated_on = answer.updated_on
				@object.expires_on = answer.expires_on
				@object.registrar = answer.registrar
				@object.nameservers = answer.nameservers
				@object.fulltext = answer.to_s
	
				## It's not guaranteed that these methods will be available..
				@object.registered = answer.registered
				@object.available = answer.available
				@object.registrant_contact = answer.registrant_contact
				@object.admin_contact = answer.admin_contact
				@object.technical_contact = answer.techncial_contact
			end
		rescue Exception => e
			puts "Something bad happened. Probably unable to parse the response :("
			puts e.to_s
		end
		
		@object.save!
		
		nil
	end

	def valid?
		return true
	end
