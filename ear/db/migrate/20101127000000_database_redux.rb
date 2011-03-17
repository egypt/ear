class DatabaseRedux < ActiveRecord::Migration
  def self.up

	create_table :tasks do |t|
		t.string 	:type
		t.string 	:target_type
		t.bool		:executed
		t.timestamps
	end

	create_table :locations do |t|
		t.float 	:latitude
		t.float 	:longitude
		t.string	:city
		t.string 	:state
		t.string	:zip
		t.string 	:country
		t.timestamps
	end

	create_table :organizations do |t|
		t.string 	:name
		t.text		:description
		t.string	:address
		t.integer 	:location_id
		t.timestamps
	end
	
	create_table :networks do |t|
		t.text 		:description
		t.string 	:range
		t.integer 	:organization_id
		t.timestamps
	end

	create_table :hosts do |t|
		t.string 	:ip
		t.string 	:name
		t.text 		:description
		t.string	:function
		t.integer 	:traffic_count, :default => 1
		t.integer 	:location_id
		t.integer 	:network_id
		t.integer 	:domain_id
		t.timestamps
	end

	create_table :services do |t|
		t.string 	:name
		t.text 		:description
		t.string	:type
		t.string 	:address
		t.integer 	:host_id
		t.timestamps
	end

	create_table :domains do |t|
	 	t.integer 	:host_id
		t.string 	:name
		t.text 		:description
		t.string 	:referral_whois
		t.string 	:referral_url
		t.string 	:status
		t.string 	:registered
		t.string	:available
		t.string	:created_on
		t.string 	:updated_on
		t.string 	:expires_on
		t.string 	:registrar
		t.string	:registrant_contact
		t.string 	:admin_contact
		t.string 	:technical_contact
		t.string 	:nameservers
		t.text 		:disclaimer
		t.text		:fulltext
		t.integer 	:organization_id
		t.timestamps
	end

	create_table :users do |t|
		t.string 	:fname
		t.string	:lname
		t.string	:alias
		t.string	:mask
		t.string 	:email
		t.integer 	:organization_id
		t.integer 	:location_id
		t.timestamps
	end
	
	create_table :task_runs do |t|
    		t.string 	:task_name
    		t.integer 	:task_object_id
    		t.string 	:task_object_type
    		t.string 	:task_options_hash
		t.timestamps
	end
	
	create_table :object_mappings do |t|
	  t.integer 	:child_id 
	  t.string 	:child_type
	  t.integer	:parent_id
	  t.string 	:parent_type
	  t.integer 	:task_run_id
	  t.string	:description
	  t.timestamp
 	end
	
  end

  def self.down

	drop_table :locations
	drop_table :organizations
	drop_table :networks
	drop_table :hosts
	drop_table :services
	drop_table :domains
	drop_table :users
	drop_table :object_mappings
	drop_table :facts
	
  end
end
