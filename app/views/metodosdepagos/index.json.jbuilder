json.array!(@metodosdepagos) do |metodosdepago|
  json.extract! metodosdepago, :id, :nombre
  json.url metodosdepago_url(metodosdepago, format: :json)
end
