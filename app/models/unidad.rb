class Unidad < ActiveRecord::Base
  has_many :producto
  
  default_scope { order('nombre ASC') }
  
end
