#!/usr/bin/env ruby

require '../config/environment'

while true
	hosts = Host.find(:all)
	
	hosts.each do |host|
		if !host.lookup
			puts "DEBUG: Getting info for: #{host.ip}"
			host.get_info
	
			## do domain lookup
			if host.name
				host.domains.each do |domain|
					puts "DEBUG: Working on: #{domain.name}"
					
					if !domain.lookup
						puts "DEBUG: Getting info for: #{domain.name}"
						domain.get_info
					else 
						puts "DEBUG: Already looked up: #{domain.name}"
					end

					## banging on whois servers is ill-advised.
					sleep 10
				end
			end
		else
			puts "DEBUG: Already looked up: #{host.ip}"
		end
	end
	sleep 10
end 


