Rails.application.routes.draw do
  post '/analyze', to: 'analyzer#create_or_show'
end
