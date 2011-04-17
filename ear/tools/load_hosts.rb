#!/usr/bin/ruby

require 'config/environment'

f = File.open("../wikimedia_hosts")

f.each { |line| 
#	begin
		if line
	#		puts line
			h = Host.create :name => line.chomp, :ip => "0.0.0.0"
			h.save!
			puts h.inspect
			#h.run_task("lookup")
		end
#	rescue Exception => e
#		puts e
#	end
}
