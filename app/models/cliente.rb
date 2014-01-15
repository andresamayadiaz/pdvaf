class Cliente < ActiveRecord::Base
  has_many :remisiones, dependent: :destroy
  
  belongs_to :empresa
  
  default_scope { order('nombre ASC') }
end
