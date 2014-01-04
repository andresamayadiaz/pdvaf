json.array!(@traslados) do |traslado|
  json.extract! traslado, :id, :tipo, :nombre, :tasa
  json.url traslado_url(traslado, format: :json)
end
