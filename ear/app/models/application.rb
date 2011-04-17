class Application
	attr_accessor :task_manager
	attr_accessor :object_manager
	attr_accessor :root
	
	def initialize
		## EAR specific configuration
		@root = Rails.root

		## Set up task manager
		@task_manager = TaskManager.instance
		@task_manager.setup("#{@root}/lib/ear/tasks")
		
		## Set up the object manager
		@object_manager = ObjectManager.instance
	end


  def import
     import_file = params[:import_file]
     FasterCSV.parse(import_file.read).each do |row|
        temp_user = TempUser.new(:email => row[0], :first_name => row[1], :last_name => row[2])
        unless temp_user.save
           temp_user.is_valid = false
           temp_user.save(false)
        end
     end
  end

  # borrowed from Scott Becker http://synthesis.sbecker.net/articles/2007/06/07/how-to-generate-csv-files-in-rails
  def export
    temp_user = TempUser.find(:all)

    csv_string = FasterCSV.generate do |csv|
      temp_users.each do |user|
        csv << [user.email, user.first_name, user.last_name]
      end
    end

    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=users.csv"
  end

  def load_file(file)
    f = File.open(file)

    f.each { |line| 
            begin
                    if line
                            import_line = line.split(",").first
                            case import_line.first
                            when "domain"
                              Domain.create :name => import_line[1].chomp
                            when "host"
                              Host.create :ip => import_line[1].chomp
                          end  
                    end
            rescue Exception => e
                    #puts e
            end
    }
  end

	def objects
		@object_manager.objects
	end
	
	def tasks
		@task_manager.tasks
	end
	
	def run_task(name, object, options={})
		@task_manager.run_task(name, object, options)
	end

	def find_host(ip)
		Host.find_by_ip(ip)
	end

	def find_organization(name)
		Organization.find_by_name(name)
	end

	def find_network(range)
		Network.find_by_range(range)
	end		

	def find_domain(name)
		Domain.find_by_domain(name)
	end

	def find_email(name)
		User.find_by_email(email)
	end

	def find_service(name)
		Service.find_by_name(name)
	end

	def hosts
		Host.all
	end
	
	def organizations
		Organization.all
	end
	
	def networks
		Network.all
	end
	
	def domains
		Domain.all
	end
	
	def users
		User.all
	end
	
	def locations
		Location.all
	end
	
	def services
		Service.all
	end

end
