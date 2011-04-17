require File.dirname(__FILE__) + '/model_helper'

class WebApplication < ActiveRecord::Base
  has_many :object_mappings
  #after_create :after_create
 
  belongs_to :service
  
  validates_presence_of :name
  
	include ModelHelper
	
  def to_s
	  "#{self.class}: #{self.name}"
	end
end
