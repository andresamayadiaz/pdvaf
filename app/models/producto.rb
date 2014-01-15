class Producto < ActiveRecord::Base
  belongs_to :unidad
  belongs_to :empresa
  
  validates :codigobarras, uniqueness: { scope: :empresa,
      message: "El Codigo de Barras no puede Duplicarse" }
  
  default_scope { order('nombre ASC') }
  
end
