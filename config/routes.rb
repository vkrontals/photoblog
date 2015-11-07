Rails.application.routes.draw do
  resources :users, only: [:show], as: :author, path: :author

  root 'pages#home'

  %w{ home
      camera-gear
      archives
      styleguide }.each do |page|

    get "/#{page}"  => "pages##{ page.underscore }"
  end

  get '/sitemap_index' => 'sitemaps#index'
  get '/post-sitemap'  => 'sitemaps#posts'
  get '/page-sitemap'  => 'sitemaps#pages'
  get '/image-sitemap' => 'sitemaps#images'

  get '/blog' => 'posts#index', as: 'blog'

  get '/:id' => 'posts#show', as: 'post'

end
