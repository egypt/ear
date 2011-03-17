require File.dirname(__FILE__) + '/model_helper'
require 'iconv'

class Host < ActiveRecord::Base
	belongs_to :network
	belongs_to :location
	has_one    :organization, :through => :network
	has_many   :users, :through => :organization
	has_many   :domains
	has_many   :services
	has_many   :object_mappings

	after_create :after_create

	validates_uniqueness_of :ip
	validates_presence_of :ip

	include ModelHelper

	def domain_string
		ds = nil
		if name
			split_ptr = name.split(".")
			tld = split_ptr[split_ptr.count-1]
			d = split_ptr[split_ptr.count-2]
			ds = d + "." + tld
		end
	return ds
	end

  def lookup
    self.run_task("lookup")
  end

  def locate
    self.run_task("Geolocate")
  end

  def command(command_string)
    self.run_task("command", {:command => command_string})
  end
  
  def nmap
    self.run_task("Nmap")
  end
  
  def msf_module(mod, options)
  	
  	msf_options = options
  	msf_options.merge({:module => mod})
	self.run_task("msf", msf_options )
  end

  def msf_pro_task(task, options)
  	
  	msf_options = options
  	msf_options.merge({:task => task})
	self.run_task("msf_pro", msf_options )
  end
  
  
  def whois
    self.run_task("Whois")
  end
  
  def example
    self.run_task("Example")
  end

end
