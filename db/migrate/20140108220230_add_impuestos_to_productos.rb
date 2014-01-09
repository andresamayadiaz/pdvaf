class AddImpuestosToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :ivatrasladado, :decimal
    add_column :productos, :iepstrasladado, :decimal
    add_column :productos, :ivaretenido, :decimal
    add_column :productos, :isrretenido, :decimal
  end
end
