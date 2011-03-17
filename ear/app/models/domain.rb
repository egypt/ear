require File.dirname(__FILE__) + '/model_helper'

class Domain < ActiveRecord::Base
	has_many :object_mappings
	#has_many :hosts	
	
	after_create :after_create
	
	validates_uniqueness_of :name
	
	include ModelHelper
	
	def lookup
    		self.run_task("lookup")
  	end	
end
