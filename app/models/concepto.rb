class Concepto < ActiveRecord::Base
  belongs_to :remision
  
  def calc_importe
    
    if self.valorunitario.nil?
      
      self.valorunitario = 0
      
    end
    
    if self.cantidad.nil?
      
      self.cantidad = 0
      
    end
    
    self.importe = self.cantidad * self.valorunitario
    
  end
  
end
