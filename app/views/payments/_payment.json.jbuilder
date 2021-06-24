json.extract! payment, :id, :status, :anount, :chargeid, :order_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
