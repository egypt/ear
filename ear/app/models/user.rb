require File.dirname(__FILE__) + '/model_helper'

class User < ActiveRecord::Base
	has_many :object_mappings
	has_many :email_addresses

	belongs_to :organization
	has_one :location

	include ModelHelper

	def to_s
	  "#{self.class}: #{self.lname}, #{self.fname}"
	end

	def full_name
		"#{fname} #{lname}"
	end

end
