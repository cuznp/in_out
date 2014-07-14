ClioInOutStub::Application.routes.draw do

  devise_for :users
<<<<<<< HEAD

  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
    end
  end
=======
 
  resources :users, :only => [:index, :show, :edit, :update] do
    member do
      get :status
      get :leave_team
      put :join_team
    end

  end
  resources :teams
>>>>>>> f213513f799935cd92e2460be823efb2a44a9a19

  root :to => "users#index"

end
