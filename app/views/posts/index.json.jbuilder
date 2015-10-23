json.array!(@posts) do |post|
  json.extract! post, :id, :index, :show
  json.url post_url(post, format: :json)
end
