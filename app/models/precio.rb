class Precio < ActiveRecord::Base
  
  belongs_to :listadeprecio
  belongs_to :producto
  
  validates :precio, :listadeprecio, presence: true
  
  validates :listadeprecio, :uniqueness => { :scope => :producto }
  
end
