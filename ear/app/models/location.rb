require File.dirname(__FILE__) + '/model_helper'

class Location < ActiveRecord::Base
  has_many :object_mappings
  include ModelHelper
  
  def to_s
	  "#{self.class}: #{self.longitude},#{self.latitude}"
	end
  
end
