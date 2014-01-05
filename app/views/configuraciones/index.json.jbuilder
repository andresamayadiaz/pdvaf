json.array!(@configuraciones) do |configuracion|
  json.extract! configuracion, :id, :nombre, :valor
  json.url configuracion_url(configuracion, format: :json)
end
