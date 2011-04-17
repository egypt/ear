class ObjectMapping < ActiveRecord::Base
  	has_one :task_run
  
  	def get_child
  	  eval "#{child_type}.find child_id"
  	end
  	
  	def get_parent
		  eval "#{parent_type}.find parent_id"
  	end
     
		def to_s
		  "#{self.class}: #{child_type}:#{child_id} <-> #{parent_type}:#{parent_id}"
		end     
     
end
