class Empresa < ActiveRecord::Base
  
  has_many :sucursales
  has_many :users
  
  validates :rfc, uniqueness: true
  
end
