json.array!(@formasdepagos) do |formasdepago|
  json.extract! formasdepago, :id, :nombre
  json.url formasdepago_url(formasdepago, format: :json)
end
