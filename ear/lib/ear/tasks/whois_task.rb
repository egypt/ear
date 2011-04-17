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
				answer = @client.query(@object.ip)
				split_answer = answer.to_s.split("\n")			
				
				split_answer.each { |line|

					## Attach Netrange
					if line =~ /CIDR/
						cidr = line
						#n = Network.create(:range => cidr.split(" ").last)
						#n.add_fact("Created from a whois lookup on: " + @object.ip + "(" + cidr + ")")	
						
            walker = Rex::Socket::RangeWalker.new(line)
        		walker.each { |ip| Device.create(:ip_address => ip)}
					  
					end
				
					## Attach Nameserver
					if line =~ /NameServer/
						nameserver = line
						h = Device.create(:name => nameserver.split(" ").last)
						#h.add_fact("Created from a whois lookup on: " + @object.ip + "(" + nameserver + ")")	
						h.lookup
					end

				## Attach Domain
				
				## Attach Contact
				
				## Organization
				
				}

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
			puts e.to_s
		end
		
		@object.save!
		
		nil
	end

	def valid?
		return true
	end
