class DatabaseRedux < ActiveRecord::Migration
  def self.up
  	create_table :tasks do |t|
  		t.string 	:type
  		t.string 	:target_type
  		t.bool		:executed
  		t.timestamps
  	end
  
  	create_table :task_runs do |t|
      t.string 	:task_name
      t.integer :task_object_id
      t.string 	:task_object_type
      t.string 	:task_options_hash
  		t.timestamps
  	end
	
  	create_table :object_mappings do |t|
  	  t.integer 	:child_id 
  	  t.string 	  :child_type
  	  t.integer	  :parent_id
  	  t.string 	  :parent_type
  	  t.integer 	:task_run_id
  	  t.string	  :description
  	  t.timestamp
   	end	

    create_table  :facts do |t|
      t.text      :text
      t.integer   :user_id
      t.integer   :email_address_id
      t.integer   :organization_id
      t.integer   :location_id
      t.integer   :domain_id
      t.integer   :device_id
      t.integer   :device_address_id
      t.integer   :service_id
      t.integer   :application_id
      t.integer   :web_application_id
      t.timestamps  
    end

  	create_table :locations do |t|
  		t.float 	:latitude
  		t.float 	:longitude
  		t.string  :address
  		t.string	:city
  		t.string 	:state
  		t.string	:zip
  		t.string 	:country
  		t.integer :user_id
  		t.integer :organization_id
  		t.timestamps
  	end

  	create_table :organizations do |t|
  		t.string 	  :name
  		t.text		  :description
  		t.string  	:address
  		t.string    :email_mask
#  		t.integer   :domain_id
#  		t.integer   :device_id
#  		t.integer   :user_id
#  		t.integer   :location_id
  		t.timestamps
  	end

  	create_table :domains do |t|
  		t.string 	  :name
  		t.text 		  :description
  		t.string 	  :referral_whois
  		t.string 	  :referral_url
  		t.string 	  :status
  		t.string 	  :registered
  		t.string	  :available
  		t.string	  :created_on
  		t.string 	  :updated_on
  		t.string 	  :expires_on
  		t.string 	  :registrar
  		t.string	  :registrant_contact
  		t.string 	  :admin_contact
  		t.string 	  :technical_contact
  		t.string 	  :nameservers
  		t.text 		  :disclaimer
  		t.text		  :fulltext
  		t.integer 	:organization_id
  		t.timestamps
  	end
    
  	create_table :users do |t|
  		t.string 	  :fname
  		t.string	  :lname
  		t.string	  :alias
  		t.integer 	:organization_id
  		t.timestamps
  	end
  	
    create_table :email_addresses do |t|
      t.string    :address
      t.integer   :user_id
    end
    
  	create_table :devices do |t|
  		t.integer 	:traffic_count, :default => 1
      t.string    :mac_address
  	  t.string    :ip_address
  		t.string 	  :name
  		t.text 		  :description
  		t.string	  :function
      t.integer   :organization_id
      t.integer   :location_id
  		t.timestamps
  	end

  	create_table :services do |t|
  		t.string 	  :name
  		t.text 		  :description
  		t.string	  :type
  		t.integer   :port
  		t.integer 	:device_id
  		t.timestamps
  	end

    create_table :net_applications do |t|
      t.string    :name
      t.string    :description
      t.string    :version
      t.integer   :service_id
      t.timestamps
    end

    create_table :web_applications do |t|
      t.string    :name
      t.string    :uri
      t.string    :description
      t.string    :version
      t.integer   :service_id
      t.timestamps
    end
  end

  def self.down  
	  drop_table :tasks
	  drop_table :facts
	  drop_table :locations
	  drop_table :organizations
	  drop_table :networks
	  drop_table :domains
	  drop_table :users
    drop_table :email_addresses
	  drop_table :devices
	  drop_table :services
    drop_table :net_applications
    drop_table :web_applications
	  drop_table :task_runs
	  drop_table :object_mappings
  end
end
