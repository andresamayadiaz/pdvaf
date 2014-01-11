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
      @empresa.save!
      self.empresa = @empresa
    end
    
  end

end
