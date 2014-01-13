class Producto < ActiveRecord::Base
  belongs_to :unidad
  
  validates :codigobarras, uniqueness: true
  
  default_scope { order('nombre ASC') }
  
end
