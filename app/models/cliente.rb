class Cliente < ActiveRecord::Base
  has_many :remisiones, dependent: :destroy
  
  belongs_to :empresa
  
  default_scope { order('nombre ASC') }
  
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
