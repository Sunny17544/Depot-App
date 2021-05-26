json.extract! cart, :id, :title, :price, :created_at, :updated_at
json.url cart_url(cart, format: :json)
