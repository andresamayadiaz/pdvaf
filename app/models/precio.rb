class Precio < ActiveRecord::Base
  belongs_to :producto
  belongs_to :moneda
end
