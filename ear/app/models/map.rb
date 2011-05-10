class Map
 
	def map_all_devices
		self.setup_map
		
	  device = Device.all.each {|device|
      if device.location
			  generate_device_marker(device)
			else
			  device.locate
			  generate_device_marker(device)
			end
		}
		
		return @map
  end
  	
  def map_single_host(id)
		self.setup_map
    
		device = Device.find(id)
		if device.location
		  generate_device_marker(device)
		end
		
		return @map
  end
    	
protected 

 	def setup_map
 		@map = GMap.new("map")
		@map.set_map_type_init(GMapType::G_HYBRID_MAP)
		@map.control_init(:large_map => true, :map_type => true)
		@map.center_zoom_init([0,0],2)
 	end
 
	def generate_device_marker(device)
	  if device.location
		  @map.overlay_init(GMarker.new(
			  [host.location.longitude, host.location.latitude], 
			  :title => host.ip, 
			  :info_window => "Hostname: #{device.name} <br/>" +
					              "IP: #{device.ip} <br/>" +
					              "City: #{device.location.city} <br/>" + 
					              "# Packets: #{device.traffic_count} <br/>" + 
					              "<a href=\"/hosts/#{device.id}\">view</a>" )) 
		end
	end 
end
