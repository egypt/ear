require 'iconv'
require 'geoip' # see instructions above or in the geoip-howto.txt for how to get this

	def name
		"geolocate_ip"
	end

	## Returns a string which describes what this task does
	def description
		"Performs a geolocation lookup"
	end

	## Returns an array of valid types for this task
	def allowed_types
		return [Device]
	end

	def update_types
		return [Device]
	end

	## Creates these types
	def create_types
		return [Location]
	end

	def setup(object, options={})
		super(object, options)
		@db = GeoIP.new(File.join(Rails.root, 'data', 'geolitecity', 'x.dat'))
		self
	end
	
	def run
		super

    raise "No Ip!" unless @object.ip_address
    
		lookup_location = @db.city(@object.ip_address)
  
		## Handle weird characters
		if lookup_location
			count = 0
			lookup_location.each  do |value| 
				if value.kind_of? String
					lookup_location[count] = ::Iconv.conv('UTF-8//IGNORE', 'UTF-8', lookup_location[count])
				end
				count = count + 1
			end
      
     			 location = create_object Location, { :city => lookup_location[8], 
                                    				    :state => lookup_location[7], 
                                    				    :country => lookup_location[5],
        	                            			    :longitude => lookup_location[11], 
        	                           			      :latitude => lookup_location[10]}			
			      @object.location = location
		end
		
		@object.save!	
		nil
	end
	
	def cleanup
		super
	end
