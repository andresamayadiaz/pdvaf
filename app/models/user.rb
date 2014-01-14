class User < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :sucursal
  
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  before_create :set_empresa
  
  def set_empresa
    
    if self.empresa.nil?
      @empresa = Empresa.new
      @empresa.razonsocial = self.name
      @empresa.rfc = self.name
      @empresa.save!
      
      @sucursal = Sucursal.new
      @sucursal.nombre = "Matriz"
      @sucursal.consecutivo = 1
      @sucursal.empresa = @empresa
      @sucursal.save!
      
      self.sucursal = @sucursal
      self.empresa = @empresa
      self.add_role :gerente
    end
    
  end

end
