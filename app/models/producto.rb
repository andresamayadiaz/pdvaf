class Producto < ActiveRecord::Base
  belongs_to :unidad
  belongs_to :empresa
  
  validates :codigobarras, uniqueness: { scope: :empresa,
      message: "El Codigo de Barras no puede Duplicarse" }
  validates :nombre, :codigobarras, :precio, :unidad, :empresa, presence: true
  
  default_scope { order('nombre ASC') }
  
  def self.import(file, empresa)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      producto = find_by_id(row["id"]) || new
      producto.attributes = row.to_hash.slice(*Producto.attribute_names())
      producto.empresa = empresa
      producto.unidad = Unidad.first
      producto.save!
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
