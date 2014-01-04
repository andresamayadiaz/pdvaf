json.array!(@retenciones) do |retencion|
  json.extract! retencion, :id, :tipo, :nombre, :tasa
  json.url retencion_url(retencion, format: :json)
end
