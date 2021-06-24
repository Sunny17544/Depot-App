json.extract! checkout, :id, :name, :address, :email, :pay_type, :created_at, :updated_at
json.url checkout_url(checkout, format: :json)
