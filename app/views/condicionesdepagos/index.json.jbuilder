json.array!(@condicionesdepagos) do |condicionesdepago|
  json.extract! condicionesdepago, :id, :nombre
  json.url condicionesdepago_url(condicionesdepago, format: :json)
end
