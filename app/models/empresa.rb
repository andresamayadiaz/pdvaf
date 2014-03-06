class Empresa < ActiveRecord::Base
  
  has_many :sucursales, dependent: :destroy
  has_many :formasdepagos, dependent: :destroy
  has_many :condicionesdepagos, dependent: :destroy
  has_many :metodosdepagos, dependent: :destroy
  has_many :remisiones, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :unidades, dependent: :destroy
  has_many :productos, dependent: :destroy
  has_many :clientes, dependent: :destroy
  has_many :listadeprecios, dependent: :destroy
  
  validates :rfc, uniqueness: true
  
end
