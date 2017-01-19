Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'twitter/evening', to: 'twitter#evening'
  post 'twitter/midday', to: 'twitter#midday'
  post 'twitter/update', to: 'twitter#update'
  post 'twitter/midday_front', to: 'twitter#midday_front'
  post 'twitter/midday_split', to: 'twitter#midday_split'
  post 'twitter/midday_back', to: 'twitter#midday_back'
  post 'twitter/evening_front', to: 'twitter#evening_front'
  post 'twitter/evening_split', to: 'twitter#evening_split'
  post 'twitter/evening_back', to: 'twitter#evening_back'
end
