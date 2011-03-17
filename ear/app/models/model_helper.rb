
module ModelHelper

	def self.included(base)
        	  base.class_eval do

			def after_create
				puts "#{self.class} created!"
				puts self.inspect
			end
			
			def tasks
				TaskManager.instance.get_tasks_for(self)
			end

			def run_task(task)
				TaskManager.instance.run_task(task,self)
			end

			def children
				ObjectManager.instance.find_children(self.id, self.class.to_s)
			end

			def parents
				ObjectManager.instance.find_parents(self.id, self.class.to_s)
			end

=begin
			def map_child(child, task_run, description="")
				ObjectMapping.create( :parent_id => self.id, 
							:parent_type => self.class.to_s,
							:child_id => child.id,
							:child_type => child.to_s,
							:task_run_id => task_run.id,
							:description => description
							 )
			end

			def map_parent(parent,task_run,description="")
				ObjectMapping.create( 	:parent_id => parent.id,
							:parent_type => parent.class.to_s,
							:child_id => self.id,
							:child_type => self.class.to_s,
							:task_run_id => task_run.id,
							:description => description )
			end
=end
			
			def map_relationship(params)
			
				puts " Creating new object mapping for: #{params.inspect}"
			
				ObjectMapping.create( 	:parent_id => params[:parent].id,
							:parent_type => params[:parent].class.to_s,
							:child_id => self.id,
							:child_type => self.class.to_s,
							:task_run_id => params[:task_run].id,
							:description => params[:description] )
			
			end
		end
	end
end
