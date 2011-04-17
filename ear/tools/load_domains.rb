f = File.open("../data/domains_clean.txt")

f.each { |line| 
	begin
		if line
			puts line
			d = Domain.create :name => line.chomp
			d.lookup	
		end
	rescue Exception => e
		puts e
	end
}
