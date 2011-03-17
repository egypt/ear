class Map
 
	def map_all_hosts
		self.setup_map
		
	  hosts = Host.all.each {|host|
      if host.location
			  generate_host_marker(host)
			else
			  host.locate
			  generate_host_marker(host)
			end
		}
		
		return @map
  end
  	
  def map_single_host(id)
		self.setup_map
    
		host = Host.find(id)
		if host.location
		  generate_host_marker(host)
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
 
	def generate_host_marker(host)
	  if host.location
		  @map.overlay_init(GMarker.new(
			  [host.location.longitude, host.location.latitude], 
			  :title => host.ip, 
			  :info_window => "Hostname: #{host.name} <br/>" +
					  "IP: #{host.ip} <br/>" +
					  "City: #{host.location.city} <br/>" + 
					  "# Packets: #{host.traffic_count} <br/>" + 
					  "<a href=\"/hosts/#{host.id}\">view</a>" )) 
		end
	end 
end
