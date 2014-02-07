class ChangeCantidadInConceptos < ActiveRecord::Migration
  def self.up
    change_column :conceptos, :cantidad, :decimal, :precision => 10, :scale => 4
  end
end
