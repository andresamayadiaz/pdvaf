class ChangeValorunitarioInConceptos < ActiveRecord::Migration
  def self.up
    change_column :conceptos, :valorunitario, :decimal, :precision => 10, :scale => 4
    change_column :remisiones, :total, :decimal, :precision => 10, :scale => 4
    change_column :remisiones, :subtotal, :decimal, :precision => 10, :scale => 4
    change_column :remisiones, :totalimpuestosretenidos, :decimal, :precision => 10, :scale => 4
    change_column :remisiones, :totalimpuestostrasladados, :decimal, :precision => 10, :scale => 4
    change_column :remisiones, :descuento, :decimal, :precision => 10, :scale => 4
  end
end
