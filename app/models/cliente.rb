class Cliente < ActiveRecord::Base
  has_many :remisiones, dependent: :destroy
  
  default_scope { order('nombre ASC') }
end
