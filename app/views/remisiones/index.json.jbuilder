json.array!(@remisiones) do |remision|
  json.extract! remision, :id, :cliente_id, :condicionesdepago_id, :formasdepago_id, :metodosdepago_id, :subtotal, :descuento, :total, :totalimpuestosretenidos, :totalimpuestostrasladados
  json.url remision_url(remision, format: :json)
end
