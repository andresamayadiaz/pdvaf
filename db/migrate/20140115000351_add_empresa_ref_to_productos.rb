class AddEmpresaRefToProductos < ActiveRecord::Migration
  def change
    add_reference :productos, :empresa, index: true
  end
end
