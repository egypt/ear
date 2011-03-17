require 'singleton'

class ObjectManager

	include Singleton

	def initialize
	
	end

	def find_children(id, type)
		all_mapped_children = ObjectMapping.find(:all, 
					:conditions => { :parent_id => id,
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
		all_mapped_parents = ObjectMapping.find(:all, 
					:conditions => { :child_id => id,
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
		all = all | Service.find(:all)
		all = all | Host.find(:all)
		all = all | Network.find(:all)
		all = all | Domain.find(:all)
		all = all | User.find(:all)
		all = all | Organization.find(:all)
		return all
	end

	def create_host(ip)
	  Host.create :ip => ip
	end

end

