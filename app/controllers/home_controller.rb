class HomeController < ApplicationController
  
  def index
    
  end
  
  def dashboard
    
    #@remisiones_creadas = current_user.sucursal.remisiones.where("YEAR(created_at)=?", Time.zone.now.year).group("month(created_at)").count.map {|index, value| [index, value]}
    
    #@ultimosdias = current_user.sucursal.remisiones.where("created_at <= ?", Time.zone.now).group("DATE(created_at)").count
    
    #@topclientes = current_user.sucursal.remisiones.group(:cliente).sum("total")
    
    @ultimasremisiones = current_user.sucursal.remisiones.order('created_at DESC').limit(5)
    
    #@topclientes = current_user.sucursal.remisiones.select(['cliente_id', 'sum(total) AS total']).where('YEAR(created_at)=?', Time.zone.now.year).includes(:cliente).group('cliente_id').order('total DESC').limit(5)
    @distribucion_ventas = current_user.empresa.remisiones.select(['sucursal_id']).where('YEAR(convert_tz(created_at, "+00:00", "-06:00"))=?', Time.zone.now.year).group('sucursal_id').count()
    
  end
  
end
