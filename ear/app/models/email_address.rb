require File.dirname(__FILE__) + '/model_helper'

class EmailAddress < ActiveRecord::Base
	has_many :object_mappings
	#after_create :after_create

	belongs_to :user

  validates_presence_of :address

	include ModelHelper
	
	def to_s
	  "#{self.class}: #{self.address}"
	end
	
end
