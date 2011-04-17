require File.dirname(__FILE__) + '/model_helper'

class Organization < ActiveRecord::Base
	has_many :object_mappings
	#after_create :after_create

  has_many :locations
	has_many :domains
	has_many :networks
	has_many :users
	has_many :devices	
	
	validates_uniqueness_of :name
  validates_presence_of :name

	include ModelHelper
 	
 	def to_s
	  "#{self.class}: #{self.name}"
	end
 	
end
