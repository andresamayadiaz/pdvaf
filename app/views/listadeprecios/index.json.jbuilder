json.array!(@listadeprecios) do |listadeprecio|
  json.extract! listadeprecio, :id, :nombre, :descripcion
  json.url listadeprecio_url(listadeprecio, format: :json)
end
