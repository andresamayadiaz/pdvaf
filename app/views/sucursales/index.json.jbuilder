json.array!(@sucursales) do |sucursal|
  json.extract! sucursal, :id, :nombre, :direccion, :telefono, :email
  json.url sucursal_url(sucursal, format: :json)
end
