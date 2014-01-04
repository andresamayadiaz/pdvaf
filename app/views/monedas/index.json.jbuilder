json.array!(@monedas) do |moneda|
  json.extract! moneda, :id, :nombre, :codigo, :tipocambio
  json.url moneda_url(moneda, format: :json)
end
