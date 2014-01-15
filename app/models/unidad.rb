class Unidad < ActiveRecord::Base
  has_many :producto
  belongs_to :empresa
  
  default_scope { order('nombre ASC') }
  
end
