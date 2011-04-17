
module ModelHelper

	def self.included(base)
    base.class_eval do

			def after_create
        #puts "After Create!"
			  puts "New Object Created! -- #{self}"
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
			
			def map_parent(params)			
				#puts " Creating new relationship: #{params[:parent].class} (parent) to #{self.class} (child)"
			
				ObjectMapping.create( 	
				      :parent_id => params[:parent].id,
							:parent_type => params[:parent].class.to_s,
							:child_id => self.id,
							:child_type => self.class.to_s,
							:task_run_id => params[:task_run_id] || nil,
							:description => params[:description] || nil )
			
			end
			
			def map_child(params)			
				puts " Creating new parent mapping for: #{params.inspect}"
			
				ObjectMapping.create( 	
				      :parent_id => self.id,
							:parent_type => self.class.to_s,
							:child_id => params[:child].id,
							:child_type => params[:child].class.to_s,
							:task_run_id => params[:task_run_id] || nil,
							:description => params[:description] || nil )
			
			end
			
			# this is some crazy ruby shit. - use metaprogramming to associate objects 
			def associate(object)
			
			  # grab the class
			  c = object.class.to_s.downcase
			  
        # see if we have a collection of these things
        if eval("self.#{c}s")
          eval "self.#{c}s << object"
          map_child(:child=>object)          
        #if not, try to associate a singular object
        elsif eval("self.#{c}")
            eval "self.#{c}.id=object.id"
            map_child(:child=>object)
        else
          raise "I don't know how to associate that!"
		    end
		    
		  end
			
			def to_s
			  "#{self.class}: #{self.id}"
			end

    	def to_graph(indent=nil)
    	  out = "Parents: "
    	  
    	  self.parents.each { |parent| out += " #{parent}" }
        out += "\nObject: #{self.to_s}\n"
    	  out += "Children: "
    	  
    	  self.children.each { |child| out += " #{child}" }

        out
      end
			
		end
	end
end
