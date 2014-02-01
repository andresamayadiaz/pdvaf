class Remision < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :condicionesdepago
  belongs_to :formasdepago
  belongs_to :metodosdepago
  belongs_to :empresa
  belongs_to :sucursal
  has_many :conceptos, dependent: :destroy
  
  accepts_nested_attributes_for :conceptos
  
  default_scope { order('created_at DESC') }
  
  before_create :set_defaults
  
  def set_defaults
    # Establecer como No Facturada
    self.facturada ||= false
    return true
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  # Calcular los totales de la Remision
  def calc_totales
    
    subt = 0.00
    totivatras = 0.00
    totiepstras = 0.00
    totivaret = 0.00
    totisrret = 0.00
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      subt += concepto.importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.ivatrasladado.nil?
        totivatras += (concepto.importe * concepto.ivatrasladado / 100.00)
      end
      unless concepto.iepstrasladado.nil?
        totiepstras += (concepto.importe * concepto.iepstrasladado / 100.00)
      end
      unless concepto.ivaretenido.nil?
        totivaret += (concepto.importe * concepto.ivaretenido / 100.00)
      end
      unless concepto.isrretenido.nil?
        totisrret += (concepto.importe * concepto.isrretenido / 100.00)
      end
      
    end
    
    self.subtotal = subt
    self.totalimpuestostrasladados = totivatras + totiepstras
    self.totalimpuestosretenidos = totivaret + totisrret
    self.total = self.subtotal - (self.subtotal * self.descuento / 100.00) + self.totalimpuestostrasladados - self.totalimpuestosretenidos
    
  end
  
  def ivaTrasladado
    
    totivatras = 0.00
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.ivatrasladado.nil?
        totivatras += (concepto.importe * concepto.ivatrasladado / 100.00)
      end
      
    end
    
    return (totivatras * self.descuento / 100.00)
    
  end
  
  
  def iepsTrasladado
    
    totiepstras = 0.00
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.iepstrasladado.nil?
        totiepstras += (concepto.importe * concepto.iepstrasladado / 100.00)
      end
      
    end
    
    return (totiepstras * self.descuento / 100.00)
    
  end
  
  def ivaRetenido
    
    totivaret = 0.00
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.ivaretenido.nil?
        totivaret += (concepto.importe * concepto.ivaretenido / 100.00)
      end
      
    end
    
    return (totivaret * self.descuento / 100.00)
    
  end
  
  def isrRetenido
    
    totisrret = 0.00
    
    self.conceptos.each do |concepto|
      
      concepto.calc_importe
      
      if self.descuento.nil?
        self.descuento = 0.00
      end
      unless concepto.isrretenido.nil?
        totisrret += (concepto.importe * concepto.isrretenido / 100.00)
      end
      
    end
    
    return (totisrret * self.descuento / 100.00)
    
  end
  
end
