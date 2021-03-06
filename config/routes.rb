ClioInOutStub::Application.routes.draw do

  devise_for :users
 
  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
      get :leave_team
      put :join_team
    end

  end
  resources :teams

  root :to => "users#index"

end