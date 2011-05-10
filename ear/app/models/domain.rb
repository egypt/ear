require File.dirname(__FILE__) + '/model_helper'

class Domain < ActiveRecord::Base
	has_many :object_mappings
	#after_create :after_create	
	belongs_to :organization
	
	#validates_presence_of :name
	#validates_uniqueness_of :name
	
	include ModelHelper
	
	def lookup
    		self.run_task("lookup")
  end
  
  def to_s
	  "#{self.class}: #{self.name}"
	end
  
end
