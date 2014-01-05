class AddCodigobarrasToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :codigobarras, :string
  end
end
