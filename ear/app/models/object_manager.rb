require 'singleton'

class ObjectManager

	include Singleton

	def initialize
	
	end

	def find_children(id, type)
		all_mapped_children = ObjectMapping.find(
		            :all, 
					      :conditions => {  :parent_id => id,
							                    :parent_type => type})
		
		children = []
		
		if all_mapped_children.kind_of? ObjectMapping
			children << all_mapped_children.get_child
		else
			all_mapped_children.each do |mapping|
				children << mapping.get_child
			end
		end
		
		return children
		
	end
	
	def find_parents(id, type)
		all_mapped_parents = ObjectMapping.find(
		                  :all, 
					            :conditions => {  :child_id => id,
							                          :child_type => type})
		
		parents = []
		if all_mapped_parents.kind_of? ObjectMapping
			parents << all_mapped_parents.get_parent
		else
			all_mapped_parents.each do |mapping|
				parents << mapping.get_parent
			end
		end

		return parents
	end

	def objects
		all = []
		all = all | User.all
		all = all | EmailAddress.all
		all = all | Organization.all
    all = all | Domain.all
    all = all | Device.all
		all = all | Service.all
    all = all | NetApplication.all
    all = all | WebApplication.all
    all = all | Location.all
		return all
	end


end

