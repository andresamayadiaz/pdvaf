class Configuracion < ActiveRecord::Base
  
  def buscar(nombre)
  
    @valor = self.find_by_nombre(nombre)
    return @valor
    
  end
  
  def establecer(nombre, valor)
  
    
  
  end
  
end
