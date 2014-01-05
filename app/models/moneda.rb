class Moneda < ActiveRecord::Base
  has_many :precios
end
