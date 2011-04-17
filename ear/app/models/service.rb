require File.dirname(__FILE__) + '/model_helper'

class Service < ActiveRecord::Base
	has_many :object_mappings
	#after_create :after_create

	belongs_to :device
	has_many :net_applications
	has_many :web_applications

  validates_presence_of :name

	include ModelHelper
	
	def to_s
	  "#{self.class}: #{self.name}"
	end
	
end
