def name
	"hoovers"
end

## Returns a string which describes what this task does
def description
	"This task scrapes Hoovers for company info."
end

## Returns an array of valid types for this task
def allowed_types
	return [Organization]
end

## Returns an arry of types that it will update
def update_types
	[]
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
  
  require 'nokogiri'
  require 'open-uri'
  require 'cgi'
  
  # Search URI
  search_uri = "http://www.hoovers.com/search/company-search-results/100005142-1.html?type=company&term=#{@object.name}"
  doc = Nokogiri::HTML(open(search_uri))
  company_path = doc.xpath("//*[@class='company_name']").first.children.first['href']
  company_uri = "http://www.hoovers.com#{company_path}"
  
  # Open Page & Parse
   doc = Nokogiri::HTML(open(company_uri))
   
  # Get Address & Clean up
  address = (doc/"/html/body/div[3]/div[2]/table/tbody/tr/td/strong/span").inner_html
  puts "Got Address: #{address}"
    
  # Get Users
  user = (doc/"/html/body/div[3]/div[2]/div[9]/table/tbody/tr/td").inner_html

  unless user.blank?
    names = user.gsub("a href=\"/marketing/free-trial/100004836-1.html\" title=\"Email lists, email contacts, contact phone numbers, email leads, phone leads\" relatedarticles=\"false\" id=\"100004836\">E-mail</a>","").split("<") 
    puts "Got Users: #{names.join(" ")}"
  
    names.each do |name| 
      name.gsub!("&nbsp;"," ")
      fname,lname = name.split(" ")
      create_object User, { :fname => fname, :lname => lname }
    end
  end
  
	nil
end

def cleanup
	super
end
