Financial::Engine.routes.draw do
  resources :plans
  resources :investments
  resources :mortgage_adjustments

  resources :payment_types

  match 'expenses/:year/:month' => 'expenses#index', :defaults=>{:year=>nil,:month=>nil}, :conditions=>{:method=>:get}
  resources :exp_types

  resources :expenses

  root :to => 'plans#index'
end
