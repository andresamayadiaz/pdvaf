class ChangePrecioInProductos < ActiveRecord::Migration
  def self.up
    change_column :productos, :precio, :decimal, :precision => 10, :scale => 4
  end
end
