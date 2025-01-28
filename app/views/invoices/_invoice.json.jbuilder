json.extract! invoice, :id, :product, :price, :quantity, :total, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
