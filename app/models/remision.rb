class Remision < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :condicionesdepago
  belongs_to :formasdepago
  belongs_to :metodosdepago
  has_many :conceptos, dependent: :destroy
  
  accepts_nested_attributes_for :conceptos
  
  # Calcular los totales de la Remision
  def calc_totales
    
    subt = 0.00;
    totivatras = 0.00;
    totiepstras = 0.00;
    totivaret = 0.00;
    totisrret = 0.00;
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      subt += concepto.importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.ivatrasladado.nil?
        totivatras = (concepto.importe * concepto.ivatrasladado / 100.00)
        self.totalimpuestostrasladados = totivatras
      end
      unless concepto.iepstrasladado.nil?
        totiepstras = (concepto.importe * concepto.iepstrasladado / 100.00)
        self.totalimpuestostrasladados += totiepstras
      end
      unless concepto.ivaretenido.nil?
        totivaret = (concepto.importe * concepto.ivaretenido / 100.00)
        self.totalimpuestosretenidos = totivaret
      end
      unless concepto.isrretenido.nil?
        totisrret = (concepto.importe * concepto.isrretenido / 100.00)
        self.totalimpuestosretenidos += totisrret
      end
      
    end
    
    self.subtotal = subt
    self.totalimpuestostrasladados = totivatras + totiepstras
    self.totalimpuestosretenidos = totivaret + totisrret
    self.total = self.subtotal - (self.subtotal * self.descuento / 100.00) + self.totalimpuestostrasladados - self.totalimpuestosretenidos
    
  end
  
end
