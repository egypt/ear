require File.dirname(__FILE__) + '/model_helper'

class User < ActiveRecord::Base
	belongs_to :company
	belongs_to :location
	has_many :object_mappings

	after_create :after_create

	include ModelHelper

end
