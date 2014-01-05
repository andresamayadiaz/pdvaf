json.array!(@conceptos) do |concepto|
  json.extract! concepto, :id, :cantidad, :unidad, :descripcion, :valorunitario, :importe, :remision_id
  json.url concepto_url(concepto, format: :json)
end
