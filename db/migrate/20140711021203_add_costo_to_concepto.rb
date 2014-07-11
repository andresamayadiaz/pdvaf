class AddCostoToConcepto < ActiveRecord::Migration
  def change
    add_column :conceptos, :costo, :decimal, :precision => 10, :scale => 4
  end
end
