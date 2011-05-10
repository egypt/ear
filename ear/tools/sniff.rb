#!/usr/bin/env ruby

require '../config/environment'
require 'packetfu' # Line 1, require PacketFu.

@excluded = [ 	"^10.", 
		"^172.16.", 
		"^192.168" , 
		"^74.16",  #google (the map)
 		"^74.125", #google (the map)
		"^224.0.0", #multicast
		"^199.71", #whois.arin.net 
		"^199.43", #whois.arin.net
		"^199.212", #whois.arin.net 
		]
		
@included = [ 	"^216.93.249" ]

@cap = PacketFu::Capture.new(:iface => ARGV[0], :start => true, :filter => "ip") # Line 1, set up the capture object.

@cap.stream.each { |pkt| 

#	begin
	packet = PacketFu::Packet.parse(pkt)

	## Check to see if it's in our exclusion list
	excluded = false

  @excluded.each { |excluded_regex|
		  if Regexp.new(excluded_regex).match(packet.ip_daddr.to_s)
			excluded = true
			puts "Packet in the exclusion list."
			break
		  end
	  }

=begin
	included = false
	@included.each { |included_regex|
		if Regexp.new(included_regex).match(packet.ip_daddr.to_s)
			included = true
			break
		end
	}  
=end
	  	
	included = true
	next unless included && !excluded && packet.is_ip?
	
	## Check to see if we have the device's details already
    	device = device.find_by_ip(packet.ip_daddr)
	
	if device
		puts "Already looked #{device.ip} up, incrementing traffic count..."
		device.traffic_count = device.traffic_count + 1
		device.save!
		next
	end
	puts "New device: #{packet.ip_daddr}, creating a record..."
	## If we got here, we haven't seen it before. create the device record.
	device.create( :ip => packet.ip_daddr )
#  rescue
#	  puts "Something unexpected happened while parsing the packet."
#	  next
#end
}
