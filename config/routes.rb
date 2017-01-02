Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'twitter/evening', to: 'twitter#evening'
  post 'twitter/midday', to: 'twitter#midday' 
end
