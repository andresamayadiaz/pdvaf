class Sucursal < ActiveRecord::Base
  
  belongs_to :empresa
  
  has_many :users
  
  default_scope { order('nombre ASC') }
  
end
