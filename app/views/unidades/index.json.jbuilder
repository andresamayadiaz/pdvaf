json.array!(@unidades) do |unidad|
  json.extract! unidad, :id, :nombre
  json.url unidad_url(unidad, format: :json)
end
