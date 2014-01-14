class Empresa < ActiveRecord::Base
  
  has_many :sucursales, dependent: :destroy
  has_many :formasdepagos, dependent: :destroy
  has_many :condicionesdepagos, dependent: :destroy
  has_many :metodosdepagos, dependent: :destroy
  has_many :remisiones, dependent: :destroy
  has_many :users, dependent: :destroy
  
  validates :rfc, uniqueness: true
  
end
