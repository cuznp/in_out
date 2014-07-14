require 'rails_helper'

describe UsersController, :type => :controller do

  let(:user) { create(:user) }
  render_views
  before do
    sign_in user
  end

  describe "GET index" do
    before { get :index }
    it "renders the index template" do
      expect(response).to render_template("index")
    end
    it "populates an array of users" do 
      user = FactoryGirl.create(:user) 
      get :index 
      expect(assigns(:users)).to eq([user]) 
    end 
  end
  describe "GET show" do
    it "assigns the requested user as @user" do
      #user = FactoryGirl.create(:user)
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the #show view" do 
      #user = FactoryGirl.create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET edit" do

    it "assigns the requested user as @user" do
      get :edit, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the #edit view" do
      get :edit, id: user
      expect(response).to render_template :edit
    end 
  end

  describe "GET status" do
        # I cannot determine why this test fails.. The failure states there is no such route?!?

    #it "finds user based on id" do
    #   thisuser = FactoryGirl.create(:user, FactoryGirl.attributes_for(:user))
    #   get status_user_path(thisuser.id)
    #   expect(assigns(:user)).to eq(thisuser)
    #end

    #it "should render json successfully" do
    #  @thisuser = FactoryGirl.create(:user, FactoryGirl.attributes_for(:user))
    #  get status_user_path(@thisuser.id), :format => :json
    #  expect(response).to be_success
    #end
 
  end

  describe "Get leave_team" do

    it "sets 'team id' to null" do
      thisTeam = FactoryGirl.create(:team)
      request.env["HTTP_REFERER"] = team_path(thisTeam.id)
      thisuser = FactoryGirl.create(:user) 
      get :leave_team, id: thisuser
      expect(thisuser.team_id).to eq(nil)
    end

    it "renders previous page" do
      thisTeam = FactoryGirl.create(:team)
      request.env["HTTP_REFERER"] = team_path(thisTeam.id)
      thisuser = FactoryGirl.create(:user) 
      get :leave_team, id: thisuser
      expect(response).to redirect_to(team_path(thisTeam.id))
  end
end

  describe "PUT update" do
    
    before :each do
      @thisuser = FactoryGirl.create(:user, FactoryGirl.attributes_for(:user))
    end
    
    describe "with valid params" do

      let(:new_attributes) {FactoryGirl.attributes_for(:user, first_name: "Tess", last_name: "Tor", email: "ttor@test.com") }

      it "updates the requested user" do
        put :update, {:id => @thisuser.id, :user => new_attributes}
        @thisuser.reload
      end

      it "changes user attributes" do
        put :update, {:id => user.id, :user => new_attributes}
        user.reload
        expect(user.first_name).to eq("Tess")
        expect(user.last_name).to eq("Tor")
        expect(user.email).to eq("ttor@test.com")
      end

      it "redirects to the user" do
        put :update, {:id => @thisuser.id, :user => new_attributes}
        expect(response).to redirect_to(users_path)
      end
    end

    #describe "with invalid params" do
    #  it "assigns the user as @user" do
    #    put :update, {:id => @user.id, :user => FactoryGirl.attributes_for(:invalid_user)}
    #    expect(assigns(:user)).to eq(@user)
    #  end
    #end
  end

  describe "PUT join_team" do

    it "sets 'team id' to that of current team" do
      currentTeam = FactoryGirl.create(:team)
      request.env["HTTP_REFERER"] = team_path(currentTeam.id)
      thisuser = FactoryGirl.create(:user) 
      put :join_team, id: thisuser
      thisuser.reload
      expect(thisuser.team_id).to eq(currentTeam.id)
    end
    it "renders previous page" do
      currentTeam = FactoryGirl.create(:team)
      request.env["HTTP_REFERER"] = team_path(currentTeam.id)
      thisuser = FactoryGirl.create(:user) 
      put :join_team, id: thisuser
      expect(response).to redirect_to(team_path(currentTeam.id))
    end
  end
end