Rails.application.routes.draw do
  root to: 'sender#index'
  get 'send', to: 'sender#send_sms'# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
