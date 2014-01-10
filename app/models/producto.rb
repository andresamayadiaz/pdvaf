class Producto < ActiveRecord::Base
  belongs_to :unidad
  
  validates :codigobarras, uniqueness: true
end
