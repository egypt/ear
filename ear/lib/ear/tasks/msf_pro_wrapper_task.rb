## todo, require msfpro libraries here. 

	def name
		"msf_pro"
	end

	## Returns an array of valid types for this task
	def allowed_types
		[Device, EmailAddress]
	end
	
	## Returns an arry of types that it will update
	def update_types
		[]
	end

	## Returns an array of types that the task will create
	def create_types
		[]
	end

	## Returns a string which describes what this task does
	def description
		"Msf Pro Wrapper Task"
	end

	def setup(object, options={})
		super(object, options)
		
		## setup connection to msf pro
		require '/opt/metasploit-3.6.0/apps/pro/engine/lib/pro/client'

		@pro = Pro::Client.new() ## this will connect to the rpc service running on localhost:50505 

		@project_name = "EAR_#{rand(1000000000000)}"

		@pro.call('db.add_workspace', project) ## create a workspace
		@pro.call('db.set_workspace', project) ## set that workspace
		
		self
	end

	## Default method, subclasses must override this
	def run
		super
	
		whitelist = ""
		if (@object.class == Host)
			whitelist = @object.ip
		else 
			whitelist = @object.range
		end
		
		if (@options[:task] == discover)
			conf = {
				'workspace' => "default",
				'username'  => @project_name,
				"ips" => [whitelist], 
				'DS_BLACKLIST_HOSTS' =>  "",
				'DS_PORTSCAN_SPEED' =>  "3",
				'DS_PORTS_EXTRA' =>  "",
				'DS_PORTS_BLACKLIST' =>  "",
				'DS_PORTS_CUSTOM' =>  "",
				'DS_PORTSCAN_TIMEOUT' =>  "5",
				'DS_UDP_PROBES' =>  "true",
				'DS_IDENTIFY_SERVICES' => "true",
				'DS_SMBUser'   => "",
				'DS_SMBPass'   =>  "",
				'DS_SMBDomain' => "",
				'DS_DRY_RUN' =>  "false",
				'DS_SINGLE_SCAN' => "false",
				'DS_FAST_DETECT' => "false",
			    	'DS_CustomNmap' => "--reason"
			}

			puts "starting discover task"
			ret = @pro.start_discover(conf)

			task_id = ret['task_id']
			puts "started discover task " + task_id
			pro.task_wait(ret['task_id'])
			puts "done!"	
		end

		@object.save!
		nil
	end
	
	def cleanup
		super
	end
