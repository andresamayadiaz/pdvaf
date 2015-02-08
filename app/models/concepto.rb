class Concepto < ActiveRecord::Base
  belongs_to :remision
  
  def calc_importe
    
    if self.importe.nil?
      
      self.importe = 0
      
    end
    self.importe = self.cantidad * self.valorunitario
    
  end
  
end
