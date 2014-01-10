class Concepto < ActiveRecord::Base
  belongs_to :remision
  
  def calc_importe
    
    self.importe = self.cantidad * self.valorunitario
    
  end
  
end
