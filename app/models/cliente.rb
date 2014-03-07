class Cliente < ActiveRecord::Base
  has_many :remisiones, dependent: :destroy
  
  belongs_to :empresa
  belongs_to :listadeprecio
  
  default_scope { order('nombre ASC') }
  
  validates :rfc, uniqueness: { scope: :empresa,
      message: "El RFC Ya Existe." }
  validates :rfc, :nombre, :noExterior, :calle, :colonia, :municipio, :estado, :pais, :codigoPostal, :empresa, presence: true
  
  def direccion_completa
    direccion = self.calle unless self.calle.blank? 
    direccion += ", " 
    direccion += self.noExterior unless self.noExterior.blank? 
    direccion += " " 
    direccion += self.noInterior unless self.noInterior.blank? 
    direccion += ", " 
    direccion += self.colonia unless self.colonia.blank? 
    direccion += ", " 
    direccion += self.municipio unless self.municipio.blank? 
    direccion += ", " 
    direccion += self.estado unless self.estado.blank? 
    direccion += ", " 
    direccion += self.pais unless self.pais.blank? 
    direccion += ", " 
    direccion += self.codigoPostal unless self.codigoPostal.blank? 
  end
  
  def self.import(file, empresa)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      cliente = find_by_id(row["id"]) || new
      cliente.attributes = row.to_hash.slice(*Cliente.attribute_names())
      cliente.empresa = empresa
      cliente.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
end
