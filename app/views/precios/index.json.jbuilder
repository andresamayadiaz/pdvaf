json.array!(@precios) do |precio|
  json.extract! precio, :id, :producto_id, :moneda_id, :precio
  json.url precio_url(precio, format: :json)
end
