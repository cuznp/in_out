require 'rails_helper'

RSpec.describe "teams/show", :type => :view do
  before(:each) do
    @team = assign(:team, FactoryGirl.create(:team))
    @members = assign(:user, FactoryGirl.create_list(:user, 3))
    @nonmembers = assign(:user, FactoryGirl.create_list(:user, 3))
  end

  it "renders attributes in <p>" do
    render
  end
end
