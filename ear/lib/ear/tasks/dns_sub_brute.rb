require 'resolv'

def name
	"dns_sub_brute"
end

## Returns a string which describes what this task does
def description
	"Simple DNS SubDomain Brute"
end

## Returns an array of valid types for this task
def allowed_types
	[Domain]
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
  #f = File.open Rails.root + "data/subdomain.list"
  #subdomain_list_with_comments = f.read
  #subdomain_list = []
  #subdomain_list_with_comments.each_line {|line| subdomain_list << line unless line =~ /^\/\// }
  #subdomain_list.each {|sub| sub.chomp!}
  
  subdomain_list = ["www", "ns1", "ns2", "ns3", "test", "mail", "owa" ]
  
  ###
  # Domain!
  ### 

	if @object.kind_of? Domain
		if @object.name
		  subdomain_list.each do |sub|

			begin
				  domain = "#{sub}.#{@object.name}"		
					resolved_address = Resolv.new.getaddress(domain)

					if resolved_address
            create_object Domain, {:name => domain, 
                                  :organization_id => @object.organization.id}

            create_object Device, {:ip_address => resolved_address,
                                  :name => domain,
                                  :organization_id => @object.organization.id}
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
