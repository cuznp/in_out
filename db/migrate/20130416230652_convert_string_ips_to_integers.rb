class ConvertStringIpsToIntegers < ActiveRecord::Migration
  
  def up
  	
  	#Create hash to store id and corresponding ips
  	$oldCurrentIps = Hash.new
    $oldLastIps = Hash.new

    #Populate hashes with old data
  	say_with_time "Collecting ips..." do
  		User.all.each do |u|
  			puts u.id 
  			puts u.current_sign_in_ip
  			$oldCurrentIps[u.id] = u.current_sign_in_ip
  			u.current_sign_in_ip = nil
  			$oldLastIps[u.id] = u.last_sign_in_ip
  			u.last_sign_in_ip = nil
  			u.save
  		end
  	end
  	#update db
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
    
    User.reset_column_information

    #convert ips and place them back into db using the same algoritm from users.rb
    $oldCurrentIps.each do |id, field|
          value = field
	      quads = value.split('.')
	      if quads.length == 4
	        as_int = (quads[0].to_i * (2**24)) + (quads[1].to_i * (2**16)) + (quads[2].to_i * (2**8)) + quads[3].to_i
	        as_int -= 4_294_967_296 if as_int > 2147483647 # Convert to 2's complement
	      else
	        as_int = nil
	      end
	      user = User.find(id)
	      user[:current_sign_in_ip] = as_int
	      user.save
	end
	$oldLastIps.each do |id, field|
          value = field
	      quads = value.split('.')
	      if quads.length == 4
	        as_int = (quads[0].to_i * (2**24)) + (quads[1].to_i * (2**16)) + (quads[2].to_i * (2**8)) + quads[3].to_i
	        as_int -= 4_294_967_296 if as_int > 2147483647 # Convert to 2's complement
	      else
	        as_int = nil
	      end
	      user = User.find(id)
	      user[:last_sign_in_ip] = as_int
	      user.save
	end
  end

  def down
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
  end
end
