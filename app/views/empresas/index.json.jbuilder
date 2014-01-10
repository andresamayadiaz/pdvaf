json.array!(@empresas) do |empresa|
  json.extract! empresa, :id, :razonsocial, :rfc, :noExterior, :noInterior, :calle, :colonia, :municipio, :estado, :pais, :codigoPostal
  json.url empresa_url(empresa, format: :json)
end
