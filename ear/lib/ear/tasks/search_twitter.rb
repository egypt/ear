def name
	"search_twitter"
end

## Returns a string which describes what this task does
def description
	"Search twitter for this username."
end

## Returns an array of valid types for this task
def allowed_types
	return [User]
end

## Returns an arry of types that it will update
def update_types
	[User]
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
  require 'twitter'

  # Initialize a Twitter search
  search = Twitter::Search.new

  search.containing("#{@object.fname} #{@object.lname}").result_type("recent").per_page(10).each do |r|
    #puts "#{r.from_user}: #{r.text}"
    Fact.create :user_id => @object.id, :text => "#{r.from_user}: #{r.text}"
  end

  # Enough about
  search.clear

	nil
end

def cleanup
	super
	puts ""
end
