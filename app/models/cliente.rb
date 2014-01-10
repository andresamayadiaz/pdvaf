class Cliente < ActiveRecord::Base
  has_many :remisiones, dependent: :destroy
end
