class Traslado < ActiveRecord::Base
  TIPOS = %w(IVA IEPS ISR)
  validates_inclusion_of :tipo, :in => TIPOS
  
end
