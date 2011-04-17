require 'resolv'

def name
	"dns_tld_brute"
end

## Returns a string which describes what this task does
def description
	"Simple DNS Top-Level Domain Brute"
end

## Returns an array of valid types for this task
def allowed_types
	[Organization, Domain]
end

## Returns an arry of types that it will update
def update_types
	[]
end

## Returns an array of types that the task will create
def create_types
	[Domain]
end

def setup(object, options={})
	super(object, options)
	self
end

## Default method, subclasses must override this
def run
	super
  
  ## Read the TLD List and pre-process it to remove crud
  f = File.open Rails.root + "data/tld.list"
  tld_list_with_comments = f.read
  tld_list = []
  tld_list_with_comments.each_line {|line| tld_list << line unless line =~ /^\/\// }
  tld_list.each {|tld| tld.chomp!}
  
  tld_list = ["com","net", "org"]
  
  ###
  # Organization
  ###
  
	if @object.kind_of? Organization
		if @object.name
		  tld_list.each do |tld|
  
			begin
				  domain = "#{@object.name}.#{tld}"		
					resolved_address = Resolv.new.getaddress(domain)
			
					if resolved_address
            puts "Resolved Address: #{resolved_address}"
            create_object Device, :ip_address => resolved_address, 
                                  :name => domain, 
                                  :organization_id => @object.id
            create_object Domain, :name => domain, 
                                  :organization_id => @object.id
          end
          
    	  rescue Exception => e
			    puts e
			  end
		  end
  
		else
			puts "Error, object has no name to look up!"
		end
	end

  ###
  # Domain!
  ### 

	if @object.kind_of? Domain
		if @object.name
		  tld_list.each do |tld|

			begin
				  domain = "#{@object.name}.#{tld}"		
					resolved_address = Resolv.new.getaddress(domain)

					if resolved_address
            create_object Device, :ip_address => resolved_address, 
                                  :name => domain, 
                                  :domain_id => @object.id,
                                  :organization_id => @object.organization.id
          end

    	  rescue Exception => e
			    puts e
			  end
		  end

		else
			raise "Error, object has no name to look up!"
		end
	
		nil
	end
end
