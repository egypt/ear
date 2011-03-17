require File.dirname(__FILE__) + '/model_helper'

class Organization < ActiveRecord::Base
	has_many :object_mappings
	has_many :domains
	has_many :networks
	has_many :users
	belongs_to :location
	has_many :hosts, :through => :networks	

	after_create :after_create

	validates_uniqueness_of :name

	include ModelHelper
 	
end
