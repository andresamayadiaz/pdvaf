json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :rfc, :nombre, :email, :noExterior, :noInterior, :calle, :colonia, :municipio, :estado, :pais, :codigoPostal
  json.url cliente_url(cliente, format: :json)
end
