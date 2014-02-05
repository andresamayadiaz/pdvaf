class ChangeImporteInConceptos < ActiveRecord::Migration
  def self.up
    change_column :conceptos, :importe, :decimal, :precision => 10, :scale => 4
  end
end
