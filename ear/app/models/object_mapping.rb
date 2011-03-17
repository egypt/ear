class ObjectMapping < ActiveRecord::Base
  
  	has_one :task_run
  
  	def get_child
=begin
  		if child_type.kind_of? Host
  			return Host.find(child_id)	
  		elsif child_type.kind_of? Network
			return Network.find(child_id)	
  		elsif child_type.kind_of? Domain
			return Domain.find(child_id)	
  		elsif child_type.kind_of? Service
			return Service.find(child_id)	
  		elsif child_type.kind_of? Location
			return Location.find(child_id)	
		elsif child_type.kind_of? Organization
			return Organization.find(child_id)	
  		elsif child_type.kind_of? User
  			return User.find(child_id)	
  		end
=end
		eval "#{child_type}.find child_id"

  	end
  	
  	def get_parent

		eval "#{parent_type}.find parent_id"
=begin
  		if parent_type.kind_of? Host
  			return Host.find(parent_id)
  		elsif parent_type.kind_of? Network
			return Network.find(parent_id)	
  		elsif parent_type.kind_of? Domain
			return Domain.find(parent_id)	
  		elsif parent_type.kind_of? Service
			return Service.find(parent_id)	
  		elsif parent_type.kind_of? Location
			return Location.find(parent_id)	
		elsif parent_type.kind_of? Organization
			return Organization.find(parent_id)	
  		elsif parent_type.kind_of? User
  			return User.find(parent_id)	
  		end
=end
  	end
     
end
