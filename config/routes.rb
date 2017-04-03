Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'JWTCheck/encode/:data', to: 'jwt_check#encode', :format => false, :constraints => {:data => /[^\/]+/}
  get 'JWTCheck/decode/:data', to: 'jwt_check#decode', :format => false, :constraints => {:data => /[^\/]+/}
end
