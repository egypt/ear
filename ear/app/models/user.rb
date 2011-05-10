require File.dirname(__FILE__) + '/model_helper'

class User < ActiveRecord::Base
	has_many :object_mappings
	#after_create :after_create

	belongs_to :organization

  #validates_presence_of :fname, :lname

	include ModelHelper

	def to_s
	  "#{self.class}: #{self.lname}, #{self.fname}"
	end

end
