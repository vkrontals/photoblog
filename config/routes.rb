Rails.application.routes.draw do

  root 'pages#home'

  [ { from: '/cdn-cgi/cl/',         to: '/' },
    { from: '/tag/tokina-28-70mm/', to: '/blog/' },
    { from: '/sample-page/',        to: '/' },
    { from: '/page/*path',          to: '/blog/page/1' },
    { from: '/tags/centon-df-300',  to: '/tag/centon-df300/' },
    { from: '/tag/bronica-sqai/',   to: '/tag/zenza-bronica-sqai/'},
    { from: '/2015/10/',            to: '/blog/' },
    { from: '/tag/taken-with-zenza-bronica-sqai/', to: '/tag/zenza-bronica-sqai/' },
    { from: '/tag/zenzanon-ps-110mm-macro/',       to: '/tag/zenzanon-ps-110mm-f4-macro/' },
    { from: '/2015/08/',            to: '/blog/' }
  ].each do |url|
    get url[:from], to: redirect(path: url[:to])
  end

  get '/wp-content/uploads/*image_path' => 'redirects#external_images_host'

  %w{ home
      camera-gear
      archives
      styleguide }.each do |page|

    get "/#{page}"  => "pages##{ page.underscore }"
  end


  get '/feed' => 'pages#feed', defaults: { format: 'atom' }

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

  match '*a', :to => 'errors#routing', via: :get

end
