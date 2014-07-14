FactoryGirl.define do 
	
	factory :team do 
		sequence(:name){|n| "Team Test #{n}"}
	end 

	factory :invalid_team, parent: :team do |f|
		f.name nil
	end
end 