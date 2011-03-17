require File.dirname(__FILE__) + '/model_helper'

class Service < ActiveRecord::Base
	belongs_to :host
	has_one :location, :through => :host
	has_one :network, :through => :host
  	has_many :object_mappings

	after_create :after_create

	include ModelHelper
end
