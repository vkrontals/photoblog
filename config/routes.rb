Rails.application.routes.draw do

  root 'pages#home'

  %w{ home
      camera-gear
      archives
      styleguide }.each do |page|

    get "/#{page}"  => "pages##{ page.underscore }"
  end

  get '/author/:slug' => 'users#show', as: :author
  get '/sitemap_index' => 'sitemaps#index'
  get '/post-sitemap'  => 'sitemaps#posts'
  get '/page-sitemap'  => 'sitemaps#pages'
  get '/image-sitemap' => 'sitemaps#images'

  get '/blog' => 'posts#index', as: 'blog'

  get '/category/:term_slug' => 'terms#category', as: :category
  get '/tag/:term_slug' => 'terms#tag', as: :tag

  get '/blog/page/:page' => 'posts#index', as: :blog_page
  get '/category/:term_slug/page/:page' => 'terms#category', as: :category_page
  get '/tag/:term_slug/page/:page' => 'terms#tag', as: :tag_page

  get '/:id' => 'posts#show', as: 'post'

end
