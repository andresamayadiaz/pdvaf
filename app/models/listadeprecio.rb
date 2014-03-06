class Listadeprecio < ActiveRecord::Base
  
  belongs_to :empresa
  
  has_many :precios, dependent: :destroy
  
  default_scope { order('nombre ASC') }
  
  validates :nombre, presence: true
  
end
