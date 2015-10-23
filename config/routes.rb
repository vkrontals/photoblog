Rails.application.routes.draw do
  resources :posts

  root 'pages#home'

  %w{ home
      camera-gear
      archives
      styleguide
      post }.each do |page|

    get "/#{page}"  => "pages##{ page.underscore }"

  end

end
