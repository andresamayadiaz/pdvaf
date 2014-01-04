json.array!(@conceptos) do |concepto|
  json.extract! concepto, :id, :cantidad, :unidad, :descripcion, :valorUnitario, :importe
  json.url concepto_url(concepto, format: :json)
end
