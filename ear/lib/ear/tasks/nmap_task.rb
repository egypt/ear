def name
	"nmap"
end

## Returns a string which describes what this task does
def description
	"This task runs nmap on a host."
end

## Returns an array of valid types for this task
def allowed_types
	[Device]
end

## Returns an arry of types that it will update
def update_types
	[Device]
end

## Returns an array of types that the task will create
def create_types
	[]
end

def setup(object, options={})
	super(object, options)
	self
end

## Default method, subclasses must override this
def run
  super
  ## parse it here - update the host
  require 'nmap/parser'
  system("nmap -PN -sT -oX /tmp/#{@object.ip_address}_nmap #{@object.ip_address}")
  parser = Nmap::Parser.parsefile("/tmp/#{@object.ip_address}_nmap")
	
	## Create the services
	
	
	
	## Update the host here
	nil
end

def cleanup
	super
end
