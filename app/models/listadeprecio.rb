class Listadeprecio < ActiveRecord::Base
  
  belongs_to :empresa
  
  has_many :precios, dependent: :destroy
  
  has_many :clientes
  
  default_scope { order('nombre ASC') }
  
  validates :nombre, presence: true
  
  def self.import(file, empresa)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      listadeprecio = find_by_nombre(row["nombre"]) || new
      listadeprecio.attributes = row.to_hash.slice(*Listadeprecio.attribute_names())
      listadeprecio.empresa = empresa
      # Validar si el producto ya existe
      prod = Producto.where(codigobarras: row['codigobarras']).first
      unless prod == nil
        if listadeprecio.id == nil
          listadeprecio.save!
        end
        precio = Precio.new
        precio.producto = prod
        precio.listadeprecio = listadeprecio
        precio.precio = row['precio']
        precio.save!
      end
      
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
