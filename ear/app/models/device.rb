require File.dirname(__FILE__) + '/model_helper'
require 'iconv'

class Device < ActiveRecord::Base
	has_many :object_mappings

	belongs_to  :organization
	has_one     :location
	has_many    :services
#	has_many    :domains, :through => organization

  validates_presence_of :ip_address
  validates_uniqueness_of :ip_address
  #validates_uniqueness_of :mac_address

#	has_many    :users, :through => :organization
	#has_many    :applications, :through => service
  #has_many    :web_applications, :through => service

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

  def geolocate_ip
    self.run_task("geolocate_ip")
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
  
	def to_s
	  "#{self.class}: #{self.ip_address} (#{self.name})"
	end

end
