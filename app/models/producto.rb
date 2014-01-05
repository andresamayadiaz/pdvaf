class Producto < ActiveRecord::Base
  belongs_to :unidad
  has_many :precios
  
  accepts_nested_attributes_for :precios
  
  validates :codigobarras, uniqueness: true
end
