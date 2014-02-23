class Sucursal < ActiveRecord::Base
  
  belongs_to :empresa
  
  has_many :users
  has_many :remisiones
  
  default_scope { order('nombre ASC') }
  
  before_create :set_defaults
  
  def set_defaults
    self.consecutivo ||= 1
    return true
  end
  
end
