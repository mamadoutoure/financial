Financial::Engine.routes.draw do
  resources :payment_types

  match 'expenses/:year/:month' => 'expenses#index', :defaults=>{:year=>nil,:month=>nil}, :conditions=>{:method=>:get}
  resources :exp_types

  resources :expenses
end
