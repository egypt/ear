require File.dirname(__FILE__) + '/model_helper'

class Network < ActiveRecord::Base
	belongs_to :organization
	has_many :locations, :through => :hosts
	has_many :hosts
	has_many :object_mappings	

	after_create :after_create

	validates_uniqueness_of :range
	validates_presence_of :range 	

	include ModelHelper
end
