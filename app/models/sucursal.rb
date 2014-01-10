class Sucursal < ActiveRecord::Base
  
  belongs_to :empresa
  
  has_many :users
  
end
