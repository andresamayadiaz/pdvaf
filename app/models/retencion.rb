class Retencion < ActiveRecord::Base
  TIPOS = %w(IVA ISR)
  validates_inclusion_of :tipo, :in => TIPOS
  
end
