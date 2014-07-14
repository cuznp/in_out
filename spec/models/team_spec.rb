require 'rails_helper'

describe Team, :type => :model do
	let(:team) { create(:team) }

	it "has a valid factory" do 
		expect(FactoryGirl.create(:team)).to be_valid 
	end
end
