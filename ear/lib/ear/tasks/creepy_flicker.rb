require 'flickr'
require 'exifr'

def name
	"creepy_flickr"
end

## Returns a string which describes what this task does
def description
	"This task checks flickr for user checkins"
end

## Returns an array of valid types for this task
def allowed_types
	return [User]
end

## Returns an arry of types that it will update
def update_types
	[]
end

## Returns an array of types that the task will create
def create_types
	[Location]
end

def setup(object, options={})
	super(object, options)
	self
end

## Default method, subclasses must override this
def run
  super
  
  raise Exception "pending"
  
	x = create_object Location, { :longitude => longitude, :latitude => latitude }

nil
end

def cleanup
	super
end
